import 'package:formz/formz.dart';

enum EventDayValidationError { invalid }

class EventDay extends FormzInput<String, EventDayValidationError> {
  const EventDay.pure() : super.pure('');
  const EventDay.dirty([String value = '']) : super.dirty(value);

  static final _dayRegExp = RegExp(r'^(?=([1-9]|[1-2][0-9]|[3][0-1])$).*$');

  @override
  EventDayValidationError? validator(String? value) {
    return _dayRegExp.hasMatch(value ?? '')
        ? null
        : EventDayValidationError.invalid;
  }
}
