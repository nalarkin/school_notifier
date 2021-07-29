import 'package:formz/formz.dart';

enum EventYearValidationError { invalid }

class EventYear extends FormzInput<String, EventYearValidationError> {
  const EventYear.pure() : super.pure('');
  const EventYear.dirty([String value = '']) : super.dirty(value);

  static final _yearRegExp = RegExp(r'^(?=202[0-9]$).*$');

  @override
  EventYearValidationError? validator(String? value) {
    return _yearRegExp.hasMatch(value ?? '')
        ? null
        : EventYearValidationError.invalid;
  }
}
