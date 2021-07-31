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
    if (_profileBloc.state.user.subscriptions != null &&
        _profileBloc.state.user.subscriptions!.length > 0) {
      _eventSubscription = _eventRepository
          .combineAllStreams(
              (_profileBloc.state.user.subscriptions!.keys).toList())
          .listen(_mapSubscriptionStreamToEvent);
    } else {
      _eventSubscription = Stream.empty().listen((_) => null);
      add(SubscriptionEmpty());
    }
    _profileBlocSubscription =
        _profileBloc.stream.listen(_mapProfileBlocToEvent);
  }
  final EventRepository _eventRepository;
  late StreamSubscription _eventSubscription;
  late StreamSubscription _profileBlocSubscription;
  final ProfileBloc _profileBloc;

  Future<void> _mapProfileBlocToEvent(ProfileState profileState) async {
    _eventSubscription.cancel();
    if (profileState.user.subscriptions != null &&
        _profileBloc.state.user.subscriptions!.length > 0) {
      _eventSubscription = _eventRepository
          .combineAllStreams(
              (_profileBloc.state.user.subscriptions!.keys).toList())
          .listen(_mapSubscriptionStreamToEvent);
    } else {
      _eventSubscription = Stream.empty().listen((_) => null);
      add(SubscriptionEmpty());
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
    } else if (event is SubscriptionEmpty) {
      yield SubscriptionSuccess(event.subscriptions);
    }
  }

  Future<SubscriptionState> _convertSubscriptionsLoadedToState(
      SubscriptionLoaded event) async {
    _eventRepository.scheduleMultipleNotifications(event.subscriptions);
    return SubscriptionSuccess(event.subscriptions);
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    _profileBlocSubscription.cancel();
    return super.close();
  }
}
