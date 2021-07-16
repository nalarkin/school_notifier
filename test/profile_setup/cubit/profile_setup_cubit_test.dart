// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:form_inputs/form_inputs.dart';
// import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:users_repository/users_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockParent extends Mock implements Parent {}

void main() {
  const invalidNameString = '';
  const invalidFirstName = FirstName.dirty(invalidNameString);

  // const invalidFirstNameString = 'invalid';
  // const invalidFirstName = Email.dirty(invalidFirstNameString);

  const validFirstNameString = 'Test-First-Name !.,`"()';
  const validFirstName = FirstName.dirty(validFirstNameString);

  const validLastNameString = 'Test-Last-Name !.,`"()';
  const validLastName = LastName.dirty(validLastNameString);
  const invalidLastName = LastName.dirty(invalidNameString);

  const validStudentString = 'Test-Student-Name !.,`"()';
  const validStudentName = StudentName.dirty(validStudentString);
  const invalidStudentName = StudentName.dirty(invalidNameString);

  group('ProfileSetupCubit', () {
    late AuthenticationRepository authenticationRepository;
    late FirestoreParentsRepository firestoreParentsRepository;
    Parent mockParent = MockParent();

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      firestoreParentsRepository = MockFirestoreParentsRepository();
      when(
        () => firestoreParentsRepository.addNewUser(any(named: 'parent')),
      ).thenAnswer((_) async {});
    });

    test('initial state is ProfileSetupState', () {
      expect(
          ProfileSetupCubit(
            firestoreParentsRepository, mockParent
          ).state,
          ProfileSetupState());
    });

    group('firstNameChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.firstNameChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
              firstName: invalidFirstName, status: FormzStatus.invalid),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.firstNameChanged(validFirstNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('passwordChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.passwordChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            confirmedPassword: ConfirmedPassword.dirty(
              password: invalidNameString,
              value: '',
            ),
            password: invalidPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          email: validFirstName,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.passwordChanged(validPasswordString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when confirmedPasswordChanged is called first and then '
        'passwordChanged is called',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          email: validFirstName,
        ),
        act: (cubit) => cubit
          ..confirmedPasswordChanged(validConfirmedPasswordString)
          ..passwordChanged(validPasswordString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            email: validFirstName,
            password: Password.pure(),
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.invalid,
          ),
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('confirmedPasswordChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.confirmedPasswordChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            confirmedPassword: invalidConfirmedPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () =>
            ProfileSetupState(email: validFirstName, password: validPassword),
        act: (cubit) => cubit.confirmedPasswordChanged(
          validConfirmedPasswordString,
        ),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when passwordChanged is called first and then '
        'confirmedPasswordChanged is called',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          email: validFirstName,
        ),
        act: (cubit) => cubit
          ..passwordChanged(validPasswordString)
          ..confirmedPasswordChanged(validConfirmedPasswordString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: ConfirmedPassword.dirty(
              password: validPasswordString,
            ),
            status: FormzStatus.invalid,
          ),
          ProfileSetupState(
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('signUpFormSubmitted', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'does nothing when status is not validated',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.signUpFormSubmitted(),
        expect: () => const <ProfileSetupState>[],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'calls signUp with correct email/password/confirmedPassword',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          status: FormzStatus.valid,
          email: validFirstName,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpFormSubmitted(),
        verify: (_) {
          verify(
            () => authenticationRepository.signUp(
              email: validFirstNameString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when signUp succeeds',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          status: FormzStatus.valid,
          email: validFirstName,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpFormSubmitted(),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            status: FormzStatus.submissionInProgress,
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          ),
          ProfileSetupState(
            status: FormzStatus.submissionSuccess,
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          )
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signUp fails',
        build: () {
          when(
            () => authenticationRepository.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('oops'));
          return ProfileSetupCubit(firestoreParentsRepository, mockParent);
        },
        seed: () => ProfileSetupState(
          status: FormzStatus.valid,
          email: validFirstName,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpFormSubmitted(),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            status: FormzStatus.submissionInProgress,
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          ),
          ProfileSetupState(
            status: FormzStatus.submissionFailure,
            email: validFirstName,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          )
        ],
      );
    });
  });
}
