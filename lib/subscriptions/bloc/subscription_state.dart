part of 'subscription_bloc.dart';



abstract class SubscriptionState extends Equatable {
  const SubscriptionState({required this.subscriptions});

  final List<FirestoreEvent> subscriptions;

  @override
  List<Object> get props => [subscriptions];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial(subscriptions)
      : super(subscriptions: subscriptions);

  @override
  String toString() {
    return 'SubscriptionInitial { subscriptions: ${this.subscriptions}}';
  }
}

class SubscriptionSuccess extends SubscriptionState {
  const SubscriptionSuccess(subscriptions)
      : super(subscriptions: subscriptions);

  @override
  String toString() {
    return 'SubscriptionSuccess { subscriptions: ${this.subscriptions}}';
  }
}

class SubscriptionFailure extends SubscriptionState {
  const SubscriptionFailure(subscriptions, this.errorMessage)
      : super(subscriptions: subscriptions);
  final String errorMessage;

  @override
  String toString() {
    return 'SubscriptionFailure { errorMessage: $errorMessage, '
        'subscriptions: ${this.subscriptions}}';
  }
}
