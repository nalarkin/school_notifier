import 'package:formz/formz.dart';

enum EventSubscriptionIdValidationError { invalid }

class EventSubscriptionId extends FormzInput<String, EventSubscriptionIdValidationError> {
  const EventSubscriptionId.pure() : super.pure('');
  const EventSubscriptionId.dirty([String value = '']) : super.dirty(value);

  static final _subscriptionIdRegExp = RegExp(r'^(?=[0-9a-zA-Z]{20}$).*$');

  @override
  EventSubscriptionIdValidationError? validator(String? value) {
    return _subscriptionIdRegExp.hasMatch(value ?? '')
        ? null
        : EventSubscriptionIdValidationError.invalid;
  }
}
