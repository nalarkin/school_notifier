import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:school_notifier/navigation/view/navigation_page.dart';
import 'package:users_repository/users_repository.dart';

class MockUser extends Mock implements User {}

class MockParent extends Mock implements Parent {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockNavigationBloc extends MockBloc<NavigationEvent, NavigationState>
    implements NavigationBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class FakeNavigationEvent extends Fake implements NavigationEvent {}

class FakeNavigationState extends Fake implements NavigationState {}
class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}
class FakeAuthenticationState extends Fake implements AuthenticationState {}

void main() {
  group('NavigationPage', () {
    late NavigationBloc navigationBloc;
    late AuthenticationRepository authenticationRepository;
    late AuthenticationBloc authenticationBloc;

    setUpAll(() {
      registerFallbackValue<NavigationEvent>(FakeNavigationEvent());
      registerFallbackValue<NavigationState>(FakeNavigationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    });

    setUp(() {
      navigationBloc = MockNavigationBloc();
      authenticationRepository = MockAuthenticationRepository();
      authenticationBloc = MockAuthenticationBloc();
    });

    testWidgets('navigates to LoginPage when NavigationInitial()',
        (tester) async {
      when(() => navigationBloc.state).thenReturn(NavigationInitial());
      when(() => navigationBloc.stream)
          .thenAnswer((_) => Stream.value(NavigationInitial()));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            routes: allRoutes,
            home: BlocProvider.value(
                value: navigationBloc, child: const NavigationPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
    testWidgets('navigates to HomePage when NavigationParentSignInSuccess()',
        (tester) async {
      final parent = MockParent();
      // when(() => authenticationBloc.state.user).thenReturn(MockUser());
      // when(() => authenticationBloc.state).thenReturn(AuthenticationState.parent(parent));
      when(() => navigationBloc.state)
          .thenReturn(NavigationParentSignInSuccess(parent: parent));
      when(() => navigationBloc.stream).thenAnswer(
          (_) => Stream.value(NavigationParentSignInSuccess(parent: parent)));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            routes: allRoutes,
            home: BlocProvider.value(
                value: navigationBloc,
                child: BlocProvider.value(
                    value: authenticationBloc, child: const NavigationPage())),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}


// MultiRepositoryProvider buildDependencies(Widget curr) {
//   final authenticationRepository = MockAuthenticationRepository();
//   when(() => authenticationRepository.user).thenAnswer((_) => Stream.empty());
//   when(() => authenticationRepository.currentUser).thenReturn(User.empty);
//   final firstoreParentsRepository = MockFirestoreParentsRepository();

//   return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider.value(
//           value: authenticationRepository as AuthenticationRepository,
//         ),
//         RepositoryProvider.value(
//           value: firstoreParentsRepository as FirestoreParentsRepository,
//         ),
//       ],
//       child: BlocProvider(
//         create: (_) => AuthenticationBloc(
//           authenticationRepository: authenticationRepository,
//           firestoreParentsRepository: firstoreParentsRepository,
//         ),
//         child: curr,
//       ));
// }
