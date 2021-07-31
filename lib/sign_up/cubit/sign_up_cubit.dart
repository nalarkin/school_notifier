import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:key_repository/key_repository.dart';
import 'package:users_repository/users_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository, this._keyRepository,
      this._userRepository, this._key)
      : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final KeyRepository _keyRepository;
  final FirestoreKey? _key;
  final FirestoreUserRepository _userRepository;
  // final Parent _parent;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.firstName,
        state.lastName,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        confirmedPassword,
        state.firstName,
        state.lastName,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
        state.firstName,
        state.lastName,
      ]),
    ));
  }

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        state.firstName,
        lastName,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  // void studentNameChanged(String value) {
  //   final studentName = StudentName.dirty(value);
  //   emit(state.copyWith(
  //     studentName: studentName,
  //     status: Formz.validate([state.firstName, state.lastName, studentName]),
  //   ));
  // }

  // Future<void> signUpFormSubmitted(FirestoreKey key) async {
  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      FirestoreKey? recentKey =
          await _keyRepository.getKey(_key!.id.toString());
      if (_key == null || recentKey != _key) {
        print("ERROR. (recentKey != _key), unable to continue signup");
        print("recentKey = $recentKey");
        print("_key = $_key");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        return null;
      }
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );

      final _userRole = getUserRoleFromKey(_key!);

      FirestoreUser curr = FirestoreUser(
        id: _authenticationRepository.currentUser.id,
        email: state.email.value,
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        children: {},
        joinDate: DateTime.now(),
        role: _userRole,
      );
      if (_userRole == UserRole.parent && _key!.studentID.isNotEmpty) {
        FirestoreUser? possibleChild =
            await _userRepository.getFirestoreUserIfExists(_key!.studentID);
        if (possibleChild != null) {
          curr = curr.copyWith(
              subscriptions: possibleChild.subscriptions,
              classes: possibleChild.classes,
              children: {
                possibleChild.id:
                    '${possibleChild.firstName} ${possibleChild.lastName}'
              });
          var currParents = possibleChild.parents ?? {};
          currParents[curr.id] = '${curr.firstName} ${curr.lastName}';
          await _userRepository
              .updateUser(possibleChild.copyWith(parents: currParents));
        }
      }

      await _userRepository.addNewUser(curr);
      await _keyRepository.updateKey(_key!.copyWith(
        linkedUser: _authenticationRepository.currentUser.id,
      ));

      // await _keyRepository.updateKey(recentKey.copyWith(isValid: false, ))
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      print('ERROR within sign_up_cubit.dart');
      print("$e");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

UserRole getUserRoleFromKey(FirestoreKey key) {
  /// admin has all roles
  if (key.isParent && key.isStudent && key.isTeacher) {
    return UserRole.admin;
  }
  if (key.isParent) {
    return UserRole.parent;
  } else if (key.isTeacher) {
    return UserRole.teacher;
  }
  return UserRole.student;
}
