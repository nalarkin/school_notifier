import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:users_repository/users_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockSetupState extends MockCubit<ProfileSetupState>
    implements ProfileSetupCubit {}

class FakeSignUpState extends Fake implements ProfileSetupState {}

class MockFirstName extends Mock implements FirstName {}

class MockLastName extends Mock implements LastName {}

class MockStudentName extends Mock implements StudentName {}

// class MockPassword extends Mock implements Password {}

// class MockConfirmedPassword extends Mock implements ConfirmedPassword {}

void main() {
  const firstNameInputKey = Key('profileSetupForm_firstNameInput_textField');
  const lastNameInputKey = Key('profileSetupForm_lastNameInput_textField');
  const studentNameInputKey =
      Key('profileSetupForm_studentNameInput_textField');

  const profileSubmitInfoButton =
      Key('profileSetupForm_submitInfo_raisedButton');
  const testFirstName = 'Test-First-Name !.,`"()';
  const testLastName = 'Test-Last-Name !.,`"()';
  const testStudentName = 'Test-Student-Name !.,`"()';

  group('ProfileSetupForm', () {
    late ProfileSetupCubit profileSetupCubit;

    setUpAll(() {
      registerFallbackValue<ProfileSetupState>(FakeSignUpState());
    });

    setUp(() {
      profileSetupCubit = MockSetupState();
      when(() => profileSetupCubit.state).thenReturn(const ProfileSetupState());
      when(() => profileSetupCubit.signUpFormSubmitted())
          .thenAnswer((_) async {});
    });

    group('calls', () {
      testWidgets('firstNameChanged when firstName changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: ProfileSetupForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(firstNameInputKey), testFirstName);
        verify(() => profileSetupCubit.firstNameChanged(testFirstName))
            .called(1);
      });
    });
    group('calls', () {
      testWidgets('lastNameChanged when lastName changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: ProfileSetupForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(lastNameInputKey), testLastName);
        verify(() => profileSetupCubit.lastNameChanged(testLastName)).called(1);
      });
    });
    group('calls', () {
      testWidgets('studentNameChanged when studentName changes',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: ProfileSetupForm(),
              ),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(studentNameInputKey), testStudentName);
        verify(() => profileSetupCubit.studentNameChanged(testStudentName))
            .called(1);
      });
    });

    testWidgets('profileSetupFormSubmitted when submit button is pressed',
        (tester) async {
      when(() => profileSetupCubit.state).thenReturn(
        const ProfileSetupState(status: FormzStatus.valid),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: profileSetupCubit,
              child: const ProfileSetupForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(profileSubmitInfoButton));
      verify(() => profileSetupCubit.signUpFormSubmitted()).called(1);
    });

    group('renders', () {
      testWidgets('Sign Up Failure SnackBar when submission fails',
          (tester) async {
        whenListen(
          profileSetupCubit,
          Stream.fromIterable(const <ProfileSetupState>[
            ProfileSetupState(status: FormzStatus.submissionInProgress),
            ProfileSetupState(status: FormzStatus.submissionFailure),
          ]),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Profile Setup Failure'), findsOneWidget);
      });

      testWidgets('invalid firstName error text when firstName is invalid',
          (tester) async {
        final firstName = MockFirstName();
        when(() => firstName.invalid).thenReturn(true);
        when(() => profileSetupCubit.state)
            .thenReturn(ProfileSetupState(firstName: firstName));
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        expect(find.text('invalid first name'), findsOneWidget);
      });

      testWidgets('invalid lastName error text when lastName is invalid',
          (tester) async {
        final lastName = MockLastName();
        when(() => lastName.invalid).thenReturn(true);
        when(() => profileSetupCubit.state)
            .thenReturn(ProfileSetupState(lastName: lastName));
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        expect(find.text('invalid last name'), findsOneWidget);
      });

      testWidgets('invalid studentName error text when studentName is invalid',
          (tester) async {
        final studentName = MockStudentName();
        when(() => studentName.invalid).thenReturn(true);
        when(() => profileSetupCubit.state)
            .thenReturn(ProfileSetupState(studentName: studentName));
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        expect(find.text('invalid student name'), findsOneWidget);
      });

      testWidgets(
          'disabled profile setup submit button when status is not validated',
          (tester) async {
        when(() => profileSetupCubit.state).thenReturn(
          const ProfileSetupState(status: FormzStatus.invalid),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        final profileSetupButton = tester.widget<ElevatedButton>(
          find.byKey(profileSubmitInfoButton),
        );
        expect(profileSetupButton.enabled, isFalse);
      });

      testWidgets('enabled sign up button when status is validated',
          (tester) async {
        when(() => profileSetupCubit.state).thenReturn(
          const ProfileSetupState(status: FormzStatus.valid),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: const ProfileSetupForm(),
              ),
            ),
          ),
        );
        final profileSetupButton = tester.widget<ElevatedButton>(
          find.byKey(profileSubmitInfoButton),
        );
        expect(profileSetupButton.enabled, isTrue);
      });
    });

    group('navigates', () {
      testWidgets('back to previous page when submission status is success',
          (tester) async {
        whenListen(
          profileSetupCubit,
          Stream.fromIterable(const <ProfileSetupState>[
            ProfileSetupState(status: FormzStatus.submissionInProgress),
            ProfileSetupState(status: FormzStatus.submissionSuccess),
          ]),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: profileSetupCubit,
                child: buildDependencies(ProfileSetupForm()),
              ),
            ),
          ),
        );
        expect(find.byType(ProfileSetupForm), findsOneWidget);
        await tester.pumpAndSettle();
        expect(find.byType(ProfileSetupForm), findsNothing);
      });
    });
    // });
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
}
