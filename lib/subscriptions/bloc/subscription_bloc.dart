import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_repository/event_repository.dart';
import 'package:school_notifier/profile/bloc/profile_bloc.dart';
import 'package:users_repository/users_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc(
    this._eventRepository,
    this._profileBloc,
  ) : super(SubscriptionInitial(<FirestoreEvent>[])) {
    if (_profileBloc.state.user.subscriptions != null) {
      _eventSubscription = _eventRepository
          .combineAllStreams(
              (_profileBloc.state.user.subscriptions!.keys).toList())
          .listen(_mapSubscriptionStreamToEvent);
    } else {
      _eventSubscription = Stream.empty().listen((_) => null);
    }
    _profileBlocSubscription =
        _profileBloc.stream.listen(_mapProfileBlocToEvent);
  }
  final EventRepository _eventRepository;
  late StreamSubscription _eventSubscription;
  // late StreamSubscription _profileView;
  late StreamSubscription _profileBlocSubscription;
  final ProfileBloc _profileBloc;

  Future<void> _mapProfileBlocToEvent(ProfileState profileState) async {
    _eventSubscription.cancel();
    if (profileState.user.subscriptions != null) {
      _eventSubscription = _eventRepository
          .combineAllStreams(
              (_profileBloc.state.user.subscriptions!.keys).toList())
          .listen(_mapSubscriptionStreamToEvent);
    }
    return null;
  }

  void _mapSubscriptionStreamToEvent(List<FirestoreEvent> subscriptions) {
    subscriptions.sort((a, b) => a.eventStartTime.compareTo(b.eventStartTime));

    add(SubscriptionLoaded(subscriptions));
  }

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is SubscriptionLoaded) {
      yield await _convertSubscriptionsLoadedToState(event);
    }
  }

  Future<SubscriptionState> _convertSubscriptionsLoadedToState(
      SubscriptionLoaded event) async {
    var updatedSubscriptions = <FirestoreEvent>[];

    for (FirestoreEvent subscription in event.subscriptions) {
      // final names = await _parentsRepository
      //     .convertParticipantListToNames(subscription.participants);
      // final idFrom = await _parentsRepository
      //     .getParentFirstLastName(subscription.lastMessage.idFrom);
      // final idTo = await _parentsRepository
      //     .getParentFirstLastName(subscription.lastMessage.idTo);
      // final _otherParticipant =
      //     subscription.participants.firstWhere((id) => id != uid);
      // final idFrom = names[subscription.lastMessage.idFrom];
      // updatedSubscriptions.add(subscription.copyWith(
      //     lastMessage: subscription.lastMessage.copyWith(
      //   id: names[_otherParticipant],
      //   idFrom: names[subscription.lastMessage.idFrom],
      //   idTo: names[subscription.lastMessage.idTo],
      // )));
    }
    return SubscriptionSuccess(event.subscriptions);
  }

  // SubscriptionState _mapSubscriptionRead(SubscriptionRead event) {
  //   assert(state.subscriptions.length > event.index);
  //   Subscription convoToUpdate = state.subscriptions[event.index];
  //   var _updatedConvoList = <Subscription>[
  //     for (Subscription convo in state.subscriptions) convo
  //   ];
  //   _updatedConvoList[event.index] = _updatedConvoList[event.index].copyWith(
  //       lastMessage:
  //           _updatedConvoList[event.index].lastMessage.copyWith(read: true));
  //   return SubscriptionSuccess(_updatedConvoList);
  // }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    _profileBlocSubscription.cancel();
    return super.close();
  }
}
