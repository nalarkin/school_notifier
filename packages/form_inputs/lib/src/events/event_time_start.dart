import 'package:formz/formz.dart';

enum EventTimeStartValidationError { invalid }

class EventTimeStart
    extends FormzInput<String, EventTimeStartValidationError> {
  const EventTimeStart.pure() : super.pure('');
  const EventTimeStart.dirty([String value = '']) : super.dirty(value);

  static final _timeStartRegExp = RegExp(r'^(?=([\d]{2}:[\d]{2})$).*$');

  @override
  EventTimeStartValidationError? validator(String? value) {
    return _timeStartRegExp.hasMatch(value ?? '')
        ? null
        : EventTimeStartValidationError.invalid;
  }
}
