import 'package:formz/formz.dart';

enum EventTitleValidationError { invalid }

class EventTitle extends FormzInput<String, EventTitleValidationError> {
  const EventTitle.pure() : super.pure('');
  const EventTitle.dirty([String value = '']) : super.dirty(value);

  static final _titleRegExp = RegExp(r'^(?=.{1,20}$).*$');

  @override
  EventTitleValidationError? validator(String? value) {
    return _titleRegExp.hasMatch(value ?? '')
        ? null
        : EventTitleValidationError.invalid;
  }
}
