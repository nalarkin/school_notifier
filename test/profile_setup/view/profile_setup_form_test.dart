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

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

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

  const submitInfoButton = Key('profileSetupForm_submitInfo_raisedButton');
  const testFirstName = 'Test-First-Name !.,`"()';
  const testLastName = 'Test-Last-Name !.,`"()';
  const testStudentName = 'Test-Student-Name !.,`"()';

  group('SignUpForm', () {
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
                child: const SignUpForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(firstNameInputKey), testFirstName);
        verify(() => profileSetupCubit.firstNameChanged(testFirstName))
            .called(1);
      });
    });
  });
}
//       testWidgets('passwordChanged when password changes', (tester) async {
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         await tester.enterText(find.byKey(passwordInputKey), testLastName);
//         verify(() => profileSetupCubit.passwordChanged(testLastName)).called(1);
//       });

//       testWidgets('confirmedPasswordChanged when confirmedPassword changes',
//           (tester) async {
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         await tester.enterText(
//             find.byKey(confirmedPasswordInputKey), testConfirmedPassword);
//         verify(() => profileSetupCubit
//             .confirmedPasswordChanged(testConfirmedPassword)).called(1);
//       });

//       testWidgets('signUpFormSubmitted when sign up button is pressed',
//           (tester) async {
//         when(() => profileSetupCubit.state).thenReturn(
//           const ProfileSetupState(status: FormzStatus.valid),
//         );
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         await tester.tap(find.byKey(signUpButtonKey));
//         verify(() => profileSetupCubit.signUpFormSubmitted()).called(1);
//       });
//     });

//     group('renders', () {
//       testWidgets('Sign Up Failure SnackBar when submission fails',
//           (tester) async {
//         whenListen(
//           profileSetupCubit,
//           Stream.fromIterable(const <ProfileSetupState>[
//             ProfileSetupState(status: FormzStatus.submissionInProgress),
//             ProfileSetupState(status: FormzStatus.submissionFailure),
//           ]),
//         );
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         await tester.pump();
//         expect(find.text('Sign Up Failure'), findsOneWidget);
//       });

//       testWidgets('invalid email error text when email is invalid',
//           (tester) async {
//         final email = MockFirstName();
//         when(() => email.invalid).thenReturn(true);
//         when(() => profileSetupCubit.state)
//             .thenReturn(ProfileSetupState(email: email));
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         expect(find.text('invalid email'), findsOneWidget);
//       });

//       testWidgets('invalid password error text when password is invalid',
//           (tester) async {
//         final password = MockPassword();
//         when(() => password.invalid).thenReturn(true);
//         when(() => profileSetupCubit.state)
//             .thenReturn(ProfileSetupState(password: password));
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         expect(find.text('invalid password'), findsOneWidget);
//       });

//       testWidgets(
//           'invalid confirmedPassword error text'
//           ' when confirmedPassword is invalid', (tester) async {
//         final confirmedPassword = MockConfirmedPassword();
//         when(() => confirmedPassword.invalid).thenReturn(true);
//         when(() => profileSetupCubit.state).thenReturn(
//             ProfileSetupState(confirmedPassword: confirmedPassword));
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         expect(find.text('passwords do not match'), findsOneWidget);
//       });

//       testWidgets('disabled sign up button when status is not validated',
//           (tester) async {
//         when(() => profileSetupCubit.state).thenReturn(
//           const ProfileSetupState(status: FormzStatus.invalid),
//         );
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         final signUpButton = tester.widget<ElevatedButton>(
//           find.byKey(signUpButtonKey),
//         );
//         expect(signUpButton.enabled, isFalse);
//       });

//       testWidgets('enabled sign up button when status is validated',
//           (tester) async {
//         when(() => profileSetupCubit.state).thenReturn(
//           const ProfileSetupState(status: FormzStatus.valid),
//         );
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         final signUpButton = tester.widget<ElevatedButton>(
//           find.byKey(signUpButtonKey),
//         );
//         expect(signUpButton.enabled, isTrue);
//       });
//     });

//     group('navigates', () {
//       testWidgets('back to previous page when submission status is success',
//           (tester) async {
//         whenListen(
//           profileSetupCubit,
//           Stream.fromIterable(const <ProfileSetupState>[
//             ProfileSetupState(status: FormzStatus.submissionInProgress),
//             ProfileSetupState(status: FormzStatus.submissionSuccess),
//           ]),
//         );
//         await tester.pumpWidget(
//           MaterialApp(
//             home: Scaffold(
//               body: BlocProvider.value(
//                 value: profileSetupCubit,
//                 child: const SignUpForm(),
//               ),
//             ),
//           ),
//         );
//         expect(find.byType(SignUpForm), findsOneWidget);
//         await tester.pumpAndSettle();
//         expect(find.byType(SignUpForm), findsNothing);
//       });
//     });
//   });
// }
