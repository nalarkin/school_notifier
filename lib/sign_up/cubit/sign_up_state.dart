part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }
// enum SignUpType { parent, student, teacher, initial }

class SignUpState extends Equatable {
  const SignUpState({
    // required this.signUpType,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    // this.studentName = const StudentName.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FirstName firstName;
  final LastName lastName;
  // final StudentName studentName;
  // final SignUpType signUpType;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
        firstName,
        lastName,
      ];

  SignUpState copyWith({
    Email? email,
    // SignUpType? signUpType,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    FirstName? firstName,
    LastName? lastName,
  }) {
    return SignUpState(
      // signUpType: signUpType ?? this.signUpType,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
