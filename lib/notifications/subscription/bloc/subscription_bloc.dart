import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_repository/event_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc(EventRepository eventRepository, ) : 
  _eventRepository = eventRepository,
  super(SubscriptionInitial([]));

  EventRepository _eventRepository;

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
