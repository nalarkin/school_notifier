part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.studentName = const StudentName.pure(),
    this.parent = Parent.empty,

    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FirstName firstName;
  final LastName lastName;
  final StudentName studentName;
  final Parent parent;
  final FormzStatus status;


  @override
  List<Object> get props => [email, password, confirmedPassword, status, firstName, lastName, studentName, parent];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    FirstName? firstName,
    LastName? lastName,
    StudentName? studentName,
    Parent? parent,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      studentName: studentName ?? this.studentName,
      parent: parent ?? this.parent,
    );
  }
}


