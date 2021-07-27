import 'package:formz/formz.dart';

enum EventDescriptionValidationError { invalid }

class EventDescription extends FormzInput<String, EventDescriptionValidationError> {
  const EventDescription.pure() : super.pure('');
  const EventDescription.dirty([String value = '']) : super.dirty(value);

  static final _descriptionRegExp = RegExp(r'^(?=.{0,30}$).*$');

  @override
  EventDescriptionValidationError? validator(String? value) {
    return _descriptionRegExp.hasMatch(value ?? '')
        ? null
        : EventDescriptionValidationError.invalid;
  }
}
