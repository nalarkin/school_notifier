// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('AppBloc', () {
    final user = MockUser();
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(() => authenticationRepository.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(
        () => authenticationRepository.currentUser,
      ).thenReturn(User.empty);
    });

    test('initial state is unauthenticated when user is empty', () {
      expect(
        AuthenticationBloc(authenticationRepository: authenticationRepository).state,
        AuthenticationState.unauthenticated(),
      );
    });

    group('UserChanged', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits authenticated when user is not empty',
        build: () {
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
          return AuthenticationBloc(authenticationRepository: authenticationRepository);
        },
        seed: () => AuthenticationState.unauthenticated(),
        expect: () => [AuthenticationState.authenticated(user)],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits unauthenticated when user is empty',
        build: () {
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
          return AuthenticationBloc(authenticationRepository: authenticationRepository);
        },
        expect: () => [AuthenticationState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'invokes logOut',
        build: () {
          return AuthenticationBloc(authenticationRepository: authenticationRepository);
        },
        act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
