import 'package:formz/formz.dart';

enum EventTypeValidationError { invalid }

class EventType extends FormzInput<String, EventTypeValidationError> {
  const EventType.pure() : super.pure('');
  const EventType.dirty([String value = '']) : super.dirty(value);

  static final _typeRegExp = RegExp(r'^(?=.{1,15}$).*$');

  @override
  EventTypeValidationError? validator(String? value) {
    return _typeRegExp.hasMatch(value ?? '')
        ? null
        : EventTypeValidationError.invalid;
  }
}
