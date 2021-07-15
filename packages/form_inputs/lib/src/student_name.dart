import 'package:formz/formz.dart';

enum StudentNameValidationError { invalid }

class StudentName extends FormzInput<String, StudentNameValidationError> {
  const StudentName.pure() : super.pure('');
  const StudentName.dirty([String value = '']) : super.dirty(value);

  static final _studentNameRegExp = RegExp(r'^(?=.{1,40}$).*$');

  @override
  StudentNameValidationError? validator(String? value) {
    return _studentNameRegExp.hasMatch(value ?? '')
        ? null
        : StudentNameValidationError.invalid;
  }
}
