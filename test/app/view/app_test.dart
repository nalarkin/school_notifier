import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAppBloc extends MockBloc<AuthenticationEvent, AuthenticationState> implements AuthenticationBloc {}

class FakeAppEvent extends Fake implements AuthenticationEvent {}

class FakeAppState extends Fake implements AuthenticationState {}

void main() {
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late User user;

    setUpAll(() {
      registerFallbackValue<AuthenticationEvent>(FakeAppEvent());
      registerFallbackValue<AuthenticationState>(FakeAppState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      user = MockUser();
      when(() => authenticationRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(() => authenticationRepository.currentUser).thenReturn(user);
      when(() => user.isNotEmpty).thenReturn(true);
      when(() => user.isEmpty).thenReturn(false);
      when(() => user.email).thenReturn('test@gmail.com');
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationRepository authenticationRepository;
    late AuthenticationBloc appBloc;

    setUpAll(() {
      registerFallbackValue<AuthenticationEvent>(FakeAppEvent());
      registerFallbackValue<AuthenticationState>(FakeAppState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      appBloc = MockAppBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(const AuthenticationState.unauthenticated());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appBloc, child: const AppView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appBloc.state).thenReturn(AuthenticationState.authenticated(user));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appBloc, child: const AppView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
