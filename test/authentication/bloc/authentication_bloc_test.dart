// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';
import 'dart:async';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockUser extends Mock implements User {}

class MockParent extends Mock implements Parent {}

/// COULD USE MORE COMPREHENSIVE TESTS

void main() {
  setUpAll(() {
    registerFallbackValue(MockParent());
  });
  group('AuthenticationBloc', () {
    final user = MockUser();
    final parent = MockParent();
    late AuthenticationRepository authenticationRepository;
    late FirestoreParentsRepository firestoreParentsRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      firestoreParentsRepository = MockFirestoreParentsRepository();
      when(() => authenticationRepository.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(
        () => authenticationRepository.currentUser,
      ).thenReturn(User.empty);
    });

    test('initial state is unauthenticated when user is empty', () {
      expect(
        AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                firestoreParentsRepository: firestoreParentsRepository)
            .state,
        AuthenticationState.unauthenticated(),
      );
    });

    group('UserChanged', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits AuthenticationState.parent when Parent is not empty',
        build: () {
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => user.isEmpty).thenReturn(false);
          when(() => user.id).thenReturn('-');
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
          when(() => firestoreParentsRepository.getUserOrDefault('-'))
              .thenAnswer((_) => new Future<Parent>(() => Parent(id: '-')));
          return AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              firestoreParentsRepository: firestoreParentsRepository);
        },
        seed: () => AuthenticationState.unauthenticated(),
        // wait: Duration(seconds: 2),
        expect: () => [AuthenticationState.parent(Parent(id: '-'))],
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits AuthenticationState.parent when Parent is parent is not empty',
        build: () {
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => user.isEmpty).thenReturn(false);
          when(() => user.id).thenReturn('-');
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
          when(() => firestoreParentsRepository.getUserOrDefault('-'))
              .thenAnswer((_) => new Future<Parent>(() => Parent.empty));
          return AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              firestoreParentsRepository: firestoreParentsRepository);
        },
        seed: () => AuthenticationState.unauthenticated(),
        // wait: Duration(seconds: 2),
        expect: () => [AuthenticationState.newParent(Parent(id: '-'))],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits unauthenticated when user is empty',
        build: () {
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
          return AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              firestoreParentsRepository: firestoreParentsRepository);
        },
        expect: () => [AuthenticationState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'invokes logOut',
        build: () {
          when(() => authenticationRepository.logOut())
              .thenAnswer((_) async {});
          return AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              firestoreParentsRepository: firestoreParentsRepository);
        },
        act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
