// // ignore_for_file: prefer_const_constructors
// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:form_inputs/form_inputs.dart';
// import 'package:school_notifier/sign_up/sign_up.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:formz/formz.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:school_notifier/authentication/authentication.dart';
// import 'package:users_repository/users_repository.dart';

// class MockAuthenticationRepository extends Mock
//     implements AuthenticationRepository {}

// class MockFirestoreParentsRepository extends Mock
//     implements FirestoreParentsRepository {}

// class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

// void main() {
//   const invalidNameString = '';
//   const invalidFirstName = FirstName.dirty(invalidNameString);

//   // const invalidEmailString = 'invalid';
//   // const invalidEmail = Email.dirty(invalidEmailString);

//   const validFirstNameString = 'Test-First-Name!.,`"()';
//   const validFirstName = FirstName.dirty(validFirstNameString);

//   const validLastNameString = 'Test-Last-Name!.,`"()';
//   const validLastName = LastName.dirty(validLastNameString);
//   const invalidLastName = LastName.dirty(invalidNameString);

//   const validStudentString = 'Test-Student-Name!.,`"()';
//   const validStudentName = StudentName.dirty(validStudentString);
//   const invalidStudentName = StudentName.dirty(invalidNameString);

//   group('ProfileSetupCubit', () {
//     late FirestoreParentsRepository firestoreParentsRepository;
//     late AuthenticationRepository authenticationRepository;
//     late AuthenticationBloc authenticationBloc;

//     setUp(() {
//       firestoreParentsRepository = MockFirestoreParentsRepository();
//       when(
//         () => firestoreParentsRepository.signUp(
//           email: any(named: 'email'),
//           password: any(named: 'password'),
//         ),
//       ).thenAnswer((_) async {});

//       authenticationRepository = MockAuthenticationRepository();
//       when(
//         () => authenticationRepository.signUp(
//           email: any(named: 'email'),
//           password: any(named: 'password'),
//         ),
//       ).thenAnswer((_) async {});
//     });

//     test('initial state is SignUpState', () {
//       expect(
//           SignUpCubit(
//             firestoreParentsRepository,
//           ).state,
//           SignUpState());
//     });

//     group('emailChanged', () {
//       blocTest<SignUpCubit, SignUpState>(
//         'emits [invalid] when email/password/confirmedPassword are invalid',
//         build: () => SignUpCubit(authenticationRepository),
//         act: (cubit) => cubit.emailChanged(invalidFirstNameString),
//         expect: () => const <SignUpState>[
//           SignUpState(email: invalidFirstName, status: FormzStatus.invalid),
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [valid] when email/password/confirmedPassword are valid',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           password: validPassword,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.emailChanged(validFirstNameString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.valid,
//           ),
//         ],
//       );
//     });

//     group('passwordChanged', () {
//       blocTest<SignUpCubit, SignUpState>(
//         'emits [invalid] when email/password/confirmedPassword are invalid',
//         build: () => SignUpCubit(authenticationRepository),
//         act: (cubit) => cubit.passwordChanged(invalidPasswordString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             confirmedPassword: ConfirmedPassword.dirty(
//               password: invalidPasswordString,
//               value: '',
//             ),
//             password: invalidPassword,
//             status: FormzStatus.invalid,
//           ),
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [valid] when email/password/confirmedPassword are valid',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           email: validFirstName,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.passwordChanged(validPasswordString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.valid,
//           ),
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [valid] when confirmedPasswordChanged is called first and then '
//         'passwordChanged is called',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           email: validFirstName,
//         ),
//         act: (cubit) => cubit
//           ..confirmedPasswordChanged(validConfirmedPasswordString)
//           ..passwordChanged(validPasswordString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             email: validFirstName,
//             password: Password.pure(),
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.invalid,
//           ),
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.valid,
//           ),
//         ],
//       );
//     });

//     group('confirmedPasswordChanged', () {
//       blocTest<SignUpCubit, SignUpState>(
//         'emits [invalid] when email/password/confirmedPassword are invalid',
//         build: () => SignUpCubit(authenticationRepository),
//         act: (cubit) =>
//             cubit.confirmedPasswordChanged(invalidConfirmedPasswordString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             confirmedPassword: invalidConfirmedPassword,
//             status: FormzStatus.invalid,
//           ),
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [valid] when email/password/confirmedPassword are valid',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(email: validFirstName, password: validPassword),
//         act: (cubit) => cubit.confirmedPasswordChanged(
//           validConfirmedPasswordString,
//         ),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.valid,
//           ),
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [valid] when passwordChanged is called first and then '
//         'confirmedPasswordChanged is called',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           email: validFirstName,
//         ),
//         act: (cubit) => cubit
//           ..passwordChanged(validPasswordString)
//           ..confirmedPasswordChanged(validConfirmedPasswordString),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: ConfirmedPassword.dirty(
//               password: validPasswordString,
//             ),
//             status: FormzStatus.invalid,
//           ),
//           SignUpState(
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//             status: FormzStatus.valid,
//           ),
//         ],
//       );
//     });

//     group('signUpFormSubmitted', () {
//       blocTest<SignUpCubit, SignUpState>(
//         'does nothing when status is not validated',
//         build: () => SignUpCubit(authenticationRepository),
//         act: (cubit) => cubit.signUpFormSubmitted(),
//         expect: () => const <SignUpState>[],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'calls signUp with correct email/password/confirmedPassword',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           status: FormzStatus.valid,
//           email: validFirstName,
//           password: validPassword,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.signUpFormSubmitted(),
//         verify: (_) {
//           verify(
//             () => authenticationRepository.signUp(
//               email: validFirstNameString,
//               password: validPasswordString,
//             ),
//           ).called(1);
//         },
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [submissionInProgress, submissionSuccess] '
//         'when signUp succeeds',
//         build: () => SignUpCubit(authenticationRepository),
//         seed: () => SignUpState(
//           status: FormzStatus.valid,
//           email: validFirstName,
//           password: validPassword,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.signUpFormSubmitted(),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             status: FormzStatus.submissionInProgress,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           ),
//           SignUpState(
//             status: FormzStatus.submissionSuccess,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           )
//         ],
//       );

//       blocTest<SignUpCubit, SignUpState>(
//         'emits [submissionInProgress, submissionFailure] '
//         'when signUp fails',
//         build: () {
//           when(
//             () => authenticationRepository.signUp(
//               email: any(named: 'email'),
//               password: any(named: 'password'),
//             ),
//           ).thenThrow(Exception('oops'));
//           return SignUpCubit(authenticationRepository);
//         },
//         seed: () => SignUpState(
//           status: FormzStatus.valid,
//           email: validFirstName,
//           password: validPassword,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.signUpFormSubmitted(),
//         expect: () => const <SignUpState>[
//           SignUpState(
//             status: FormzStatus.submissionInProgress,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           ),
//           SignUpState(
//             status: FormzStatus.submissionFailure,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           )
//         ],
//       );
//     });
//   });
// }
