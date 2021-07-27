import 'package:formz/formz.dart';

enum EventStartDateValidationError { invalid }

class EventStartDate extends FormzInput<String, EventStartDateValidationError> {
  const EventStartDate.pure() : super.pure('');
  const EventStartDate.dirty([String value = '']) : super.dirty(value);

  static final _lastNameRegExp = RegExp(r'^(?=.{1,20}$).*$');

  @override
  EventStartDateValidationError? validator(String? value) {
    return _lastNameRegExp.hasMatch(value ?? '')
        ? null
        : EventStartDateValidationError.invalid;
  }
}
