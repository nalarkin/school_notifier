part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState(this.subscriptionList);
  final List<String> subscriptionList;

  @override
  List<Object> get props => [subscriptionList];
}

class SubscriptionInitial extends SubscriptionState {
  SubscriptionInitial(List<String> subscriptionList) : super(subscriptionList);

  @override
  String toString() {
    return 'SubscriptionInitial { subscriptionList: $subscriptionList }';
  }
}

class SubscriptionChanged extends SubscriptionState {
  SubscriptionChanged(List<String> subscriptionList) : super(subscriptionList);

  @override
  String toString() {
    return 'SubscriptionChanged { subscriptionList: $subscriptionList }';
  }
}
