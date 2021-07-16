import 'package:authentication_repository/authentication_repository.dart';
import 'package:users_repository/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit(this._firestoreParentsRepository, this._parent)
      : super(const ProfileSetupState());

  final FirestoreParentsRepository _firestoreParentsRepository;
  // final AuthenticationBloc _authenticationBloc;
  final Parent _parent;

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([firstName, state.lastName, state.studentName]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([state.firstName, lastName, state.studentName]),
    ));
  }

  void studentNameChanged(String value) {
    final studentName = StudentName.dirty(value);
    emit(state.copyWith(
      studentName: studentName,
      status: Formz.validate([state.firstName, state.lastName, studentName]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _firestoreParentsRepository.addNewUser(_parent.copyWith(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  // Future<void> logInWithGoogle() async {
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.logInWithGoogle();
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on Exception {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   } on NoSuchMethodError {
  //     emit(state.copyWith(status: FormzStatus.pure));
  //   }
  // }
}
