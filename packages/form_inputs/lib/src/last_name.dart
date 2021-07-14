import 'package:formz/formz.dart';

enum LastNameValidationError { invalid }

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

  static final _lastNameRegExp = RegExp(r'^[A-Za-z\d]{2,}$');

  @override
  LastNameValidationError? validator(String? value) {
    return _lastNameRegExp.hasMatch(value ?? '')
        ? null
        : LastNameValidationError.invalid;
  }
}
