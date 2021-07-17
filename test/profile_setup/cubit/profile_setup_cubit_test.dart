import 'package:bloc_test/bloc_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:users_repository/users_repository.dart';

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockParent extends Mock implements Parent {}

/// TODO: Find a way to test the signUpFormSubmitted. Currently the function
/// only emits 1 state, and the addNewUser() method is never called.
void main() {
  const invalidNameString = '';

  const validFirstNameString = 'Test-First-Name !.,`"()';
  const validFirstName = FirstName.dirty(validFirstNameString);
  const invalidFirstName = FirstName.dirty(invalidNameString);

  const validLastNameString = 'Test-Last-Name !.,`"()';
  const validLastName = LastName.dirty(validLastNameString);
  const invalidLastName = LastName.dirty(invalidNameString);

  const validStudentString = 'Test-Student-Name !.,`"()';
  const validStudentName = StudentName.dirty(validStudentString);
  const invalidStudentName = StudentName.dirty(invalidNameString);
  final mockParent = MockParent();

  group('ProfileSetupCubit', () {
    late FirestoreParentsRepository firestoreParentsRepository;
    // late mockParent;
    setUpAll(() {
      registerFallbackValue(MockParent());
      // registerFallbackValue(Parent());
    });

    setUp(() {
      firestoreParentsRepository = MockFirestoreParentsRepository();
      // mockParent =
      // when(
      //   () => firestoreParentsRepository.addNewUser(any(named: 'parent')),
      // ).thenAnswer((_) async {});
      when(() => mockParent.copyWith()).thenReturn(MockParent());
      // when(
      //   () => firestoreParentsRepository.addNewUser(any()),
      // ).thenAnswer((_) async => stubMethod(any()));

      when(
        () => firestoreParentsRepository.addNewUser(any()),
      ).thenAnswer((_) async {});
    });

    test('initial state is ProfileSetupState', () {
      expect(ProfileSetupCubit(firestoreParentsRepository, mockParent).state,
          ProfileSetupState());
    });

    group('firstNameChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when firstName/lastName/studentName are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.firstNameChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
              firstName: invalidFirstName, status: FormzStatus.invalid),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when firstName/lastName/studentName are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          firstName: validFirstName,
          lastName: validLastName,
          studentName: validStudentName,
        ),
        act: (cubit) => cubit.firstNameChanged(validFirstNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            firstName: validFirstName,
            lastName: validLastName,
            studentName: validStudentName,
            status: FormzStatus.valid,
          ),
        ],
      );
    });
    group('lastNameChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when firstName/lastName/studentName are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.lastNameChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
              lastName: invalidLastName, status: FormzStatus.invalid),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when firstName/lastName/studentName are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          firstName: validFirstName,
          lastName: validLastName,
          studentName: validStudentName,
        ),
        act: (cubit) => cubit.lastNameChanged(validLastNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            firstName: validFirstName,
            lastName: validLastName,
            studentName: validStudentName,
            status: FormzStatus.valid,
          ),
        ],
      );
    });
    group('studentNameChanged', () {
      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [invalid] when firstName/lastName/studentName are invalid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        act: (cubit) => cubit.studentNameChanged(invalidNameString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
              studentName: invalidStudentName, status: FormzStatus.invalid),
        ],
      );

      blocTest<ProfileSetupCubit, ProfileSetupState>(
        'emits [valid] when firstName/lastName/studentName are valid',
        build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
        seed: () => ProfileSetupState(
          firstName: validFirstName,
          lastName: validLastName,
          studentName: validStudentName,
        ),
        act: (cubit) => cubit.studentNameChanged(validStudentString),
        expect: () => const <ProfileSetupState>[
          ProfileSetupState(
            firstName: validFirstName,
            lastName: validLastName,
            studentName: validStudentName,
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

      // blocTest<ProfileSetupCubit, ProfileSetupState>(
      //   'calls signUp with correct email/password/confirmedPassword',
      //   build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
      //   seed: () => ProfileSetupState(
      //     status: FormzStatus.valid,
      //     firstName: validFirstName,
      //     lastName: validLastName,
      //     studentName: validStudentName,
      //   ),
      //   act: (cubit) => cubit.signUpFormSubmitted(),
      //   verify: (_) {
      //     verify(
      //       () => firestoreParentsRepository.addNewUser(any()),
      //     ).called(1);
      //   },
      // );
      // blocTest<ProfileSetupCubit, ProfileSetupState>(
      //     'calls signUp with correct email/password/confirmedPassword',
      //     build: () =>
      //         ProfileSetupCubit(firestoreParentsRepository, mockParent),
      //     seed: () => ProfileSetupState(
      //           status: FormzStatus.valid,
      //           firstName: validFirstName,
      //           lastName: validLastName,
      //           studentName: validStudentName,
      //         ),
      //     act: (cubit) => cubit.signUpFormSubmitted(),
      //     expect: () => const <ProfileSetupState>[
      //           ProfileSetupState(
      //             status: FormzStatus.submissionInProgress,
      //             firstName: validFirstName,
      //             lastName: validLastName,
      //             studentName: validStudentName,
      //           ),
      //           ProfileSetupState(
      //             status: FormzStatus.submissionSuccess,
      //             firstName: validFirstName,
      //             lastName: validLastName,
      //             studentName: validStudentName,
      //           ),
      //         ]);

      // blocTest<ProfileSetupCubit, ProfileSetupState>(
      //   'emits [submissionInProgress, submissionFailure] '
      //   'when signUp fails',
      //   build: () {
      //     when(
      //       () => firestoreParentsRepository.addNewUser(
      //         any()
      //       ),
      //     ).thenThrow(Exception('oops'));
      //     return ProfileSetupCubit(firestoreParentsRepository, mockParent);
      //   },
      //   seed: () => ProfileSetupState(
      //     status: FormzStatus.valid,
      //     firstName: validFirstName,
      //     lastName: validLastName,
      //     studentName: validStudentName,
      //   ),
      //   act: (cubit) => cubit.signUpFormSubmitted(),
      //   // wait: ,
      //   expect: () => const <ProfileSetupState>[
      //     ProfileSetupState(
      //       status: FormzStatus.submissionInProgress,
      //       firstName: validFirstName,
      //       lastName: validLastName,
      //       studentName: validStudentName,
      //     ),
      //     ProfileSetupState(
      //       status: FormzStatus.submissionFailure,
      //       firstName: validFirstName,
      //       lastName: validLastName,
      //       studentName: validStudentName,
      //     )
      //   ],
      // );
    });
  });
}




//       blocTest<ProfileSetupCubit, ProfileSetupState>(
//         'emits [submissionInProgress, submissionSuccess] '
//         'when signUp succeeds',
//         build: () => ProfileSetupCubit(firestoreParentsRepository, mockParent),
//         seed: () => ProfileSetupState(
//           status: FormzStatus.valid,
//           email: validFirstName,
//           password: validPassword,
//           confirmedPassword: validConfirmedPassword,
//         ),
//         act: (cubit) => cubit.signUpFormSubmitted(),
//         expect: () => const <ProfileSetupState>[
//           ProfileSetupState(
//             status: FormzStatus.submissionInProgress,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           ),
//           ProfileSetupState(
//             status: FormzStatus.submissionSuccess,
//             email: validFirstName,
//             password: validPassword,
//             confirmedPassword: validConfirmedPassword,
//           )
//         ],
//       );


    // });
//   });
// }

// Future<void> stubMethod(Parent p) async {
//   Future.delayed(Duration(seconds: 0));
// }
