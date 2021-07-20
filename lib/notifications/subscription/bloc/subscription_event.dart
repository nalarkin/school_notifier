part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionStarted extends SubscriptionEvent {}

class SubscriptionAdded extends SubscriptionEvent {
  SubscriptionAdded({required this.subscription});
  final subscription;

  @override
  List<Object> get props => [subscription];
}

class SubscriptionRemoved extends SubscriptionEvent {
  SubscriptionRemoved({required this.subscription});
  final subscription;

  @override
  List<Object> get props => [subscription];
}
