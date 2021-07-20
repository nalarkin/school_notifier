import 'package:formz/formz.dart';

enum TokenValidationError { invalid }

class Token extends FormzInput<String, TokenValidationError> {
  const Token.pure() : super.pure('');
  const Token.dirty([String value = '']) : super.dirty(value);

  static final _tokenRegExp = RegExp(r'^(?=[a-zA-Z0-9]{20,20}$).*$');

  @override
  TokenValidationError? validator(String? value) {
    return _tokenRegExp.hasMatch(value ?? '')
        ? null
        : TokenValidationError.invalid;
  }
}
