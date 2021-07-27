import 'package:formz/formz.dart';

enum EventDurationValidationError { invalid }

class EventDuration extends FormzInput<String, EventDurationValidationError> {
  const EventDuration.pure() : super.pure('');
  const EventDuration.dirty([String value = '']) : super.dirty(value);

  static final _durationRegExp = RegExp(r'^(?=[\d]{1,3}$).*$');

  @override
  EventDurationValidationError? validator(String? value) {
    return _durationRegExp.hasMatch(value ?? '')
        ? null
        : EventDurationValidationError.invalid;
  }
}
