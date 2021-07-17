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
import 'package:users_repository/users_repository.dart';

// class MockUser extends Mock implements User {}

// class MockAuthenticationRepository extends Mock
//     implements AuthenticationRepository {}

// class MockFirestoreParentsRepository extends Mock
//     implements FirestoreParentsRepository {}

// class MockAppBloc extends MockBloc<AuthenticationEvent, AuthenticationState>
//     implements AuthenticationBloc {}

// class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

// class FakeAuthenticationState extends Fake implements AuthenticationState {}

void main() {}
//   group('AppView', () {
//     late AuthenticationRepository authenticationRepository;
//     late AuthenticationBloc appBloc;

//     setUpAll(() {
//       registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
//       registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
//     });

//     setUp(() {
//       authenticationRepository = MockAuthenticationRepository();
//       appBloc = MockAppBloc();
//     });

//     testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
//       when(() => appBloc.state)
//           .thenReturn(const AuthenticationState.unauthenticated());
//       await tester.pumpWidget(
//         RepositoryProvider.value(
//           value: authenticationRepository,
//           child: MaterialApp(
//             home: BlocProvider.value(value: appBloc, child: const AppView()),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//       expect(find.byType(LoginPage), findsOneWidget);
//     });

//     testWidgets('naigates to HomePage when authenticated', (tester) async {
//       final user = MockUser();
//       when(() => user.email).thenReturn('test@gmail.com');
//       when(() => appBloc.state)
//           .thenReturn(AuthenticationState.authenticated(user));
//       await tester.pumpWidget(
//         RepositoryProvider.value(
//           value: authenticationRepository,
//           child: MaterialApp(
//             home: BlocProvider.value(value: appBloc, child: const AppView()),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//       expect(find.byType(HomePage), findsOneWidget);
//     });
//   });
// }