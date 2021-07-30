part of 'subscription_bloc.dart';


abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent({this.subscriptions = const <FirestoreEvent>[]});
  final List<FirestoreEvent> subscriptions;

  @override
  List<Object> get props => [subscriptions];
}

class SubscriptionStarted extends SubscriptionEvent {
  const SubscriptionStarted(subscriptions)
      : super(subscriptions: subscriptions);

  @override
  String toString() {
    return 'SubscriptionStarted { subscriptions: ${this.subscriptions}}';
  }
}

class SubscriptionLoaded extends SubscriptionEvent {
  const SubscriptionLoaded(subscriptions) : super(subscriptions: subscriptions);

  @override
  String toString() {
    return 'SubscriptionLoaded { subscriptions: ${this.subscriptions}}';
  }
}
class SubscriptionEmpty extends SubscriptionEvent {
  const SubscriptionEmpty() : super(subscriptions: const <FirestoreEvent>[]);

  @override
  String toString() {
    return 'SubscriptionLoaded { subscriptions: ${this.subscriptions}}';
  }
}

// class SubscriptionRead extends SubscriptionEvent {
//   const SubscriptionRead(this.singleSubscription, this.index) : super();
//   final Subscription singleSubscription;
//   final int index;

//   @override
//   String toString() {
//     return 'SubscriptionRead { singleSubscription: ${this.singleSubscription}}';
//   }
// }
