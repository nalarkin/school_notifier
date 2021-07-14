import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  /// below regex is temporary for debug purposes,
  static final _passwordRegExp = RegExp(r'^[A-Za-z\d]{6,}$');

  /// Below, matches password that has at least 1 letter and 1 digit,
  /// and is at least 8 characters long.
  // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
