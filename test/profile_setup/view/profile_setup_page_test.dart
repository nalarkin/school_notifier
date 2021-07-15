// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}
// class MockRepository extends Mock
//     implements FirestoreParentsRepository {}

void main() {
  group('ProfileSetupPage', () {
    test('has a route', () {
      expect(ProfileSetupPage.route(), isA<MaterialPageRoute>());
    });

    testWidgets('renders a ProfileSetupPage', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: buildDependencies(ProfileSetupPage())));
      // testWidgets('renders a ProfileSetupPage', (tester) async {
      //   await tester.pumpWidget(
      //     RepositoryProvider<AuthenticationRepository>(
      //       create: (_) => MockAuthenticationRepository(),
      //       child: BlocProvider(
      //         create: (context) => AuthenticationBloc(authenticationRepository: ),
      //         child: Container(),
      //       )

      //       MaterialApp(home: ProfileSetupPage()),
      //     ),
      //   );
      expect(find.byType(ProfileSetupPage), findsOneWidget);
    });
  });
}

MultiRepositoryProvider buildDependencies(Widget curr) {
  final authenticationRepository = MockAuthenticationRepository();
  when(() => authenticationRepository.user).thenAnswer((_) => Stream.empty());
  when(() => authenticationRepository.currentUser).thenReturn(User.empty);
  final firstoreParentsRepository = MockFirestoreParentsRepository();

  return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository as AuthenticationRepository,
        ),
        RepositoryProvider.value(
          value: firstoreParentsRepository as FirestoreParentsRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          firestoreParentsRepository: firstoreParentsRepository,
        ),
        child: curr,
      ));

  // child: MultiBlocProvider(
  //   providers: [
  //     BlocProvider(
  //         create: (_) => AuthenticationBloc(
  //               authenticationRepository: authenticationRepository,
  //               firestoreParentsRepository: firstoreParentsRepository,
  //             )),
  //   ],
  //   child: curr,
  // ));
}
