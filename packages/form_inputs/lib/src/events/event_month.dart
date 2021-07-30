import 'package:formz/formz.dart';

enum EventMonthValidationError { invalid }

class EventMonth extends FormzInput<String, EventMonthValidationError> {
  const EventMonth.pure() : super.pure('');
  const EventMonth.dirty([String value = '']) : super.dirty(value);

  static final _monthRegExp = RegExp(r'^(?=([1-9]|1[0-2])$).*$');

  @override
  EventMonthValidationError? validator(String? value) {
    return _monthRegExp.hasMatch(value ?? '')
        ? null
        : EventMonthValidationError.invalid;
  }
}
