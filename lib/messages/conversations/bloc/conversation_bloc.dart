import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(
    this._messageRepository,
    String uid,
  ) : super(ConversationInitial([])) {
    _conversationSubscription = _messageRepository
        .streamAllConversations(uid)
        .listen(_mapConversationStreamToEvent);
  }
  final MessageRepository _messageRepository;
  late StreamSubscription _conversationSubscription;

  void _mapConversationStreamToEvent(List<Conversation> conversations) {
    add(ConversationLoaded(conversations));
  }

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConversationLoaded) {
      yield ConversationSuccess(event.conversations);
    } 
  }
}
