import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';
import 'package:users_repository/users_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(
    this._messageRepository,
    this._parentsRepository,
    this.uid,
  ) : super(ConversationInitial(<Conversation>[])) {
    _conversationSubscription = _messageRepository
        .streamAllConversations(uid)
        .listen(_mapConversationStreamToEvent);
  }
  final MessageRepository _messageRepository;
  final FirestoreParentsRepository _parentsRepository;
  late StreamSubscription _conversationSubscription;
  final uid;

  void _mapConversationStreamToEvent(List<Conversation> conversations) {
    add(ConversationLoaded(conversations));
  }

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConversationLoaded) {
      yield await _convertConversationsLoadedToState(event);
    }
  }

  Future<ConversationState> _convertConversationsLoadedToState(
      ConversationLoaded event) async {
    var updatedConversations = <Conversation>[];
    for (Conversation conversation in event.conversations) {
      final idFrom = await _parentsRepository
          .getParentFirstLastName(conversation.lastMessage.idFrom);
      final idTo = await _parentsRepository
          .getParentFirstLastName(conversation.lastMessage.idTo);

      updatedConversations.add(conversation.copyWith(
          lastMessage: conversation.lastMessage.copyWith(
        idFrom: idFrom,
        idTo: idTo,
      )));
    }

    return ConversationSuccess(updatedConversations);
  }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
