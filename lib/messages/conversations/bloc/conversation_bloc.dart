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
    // this._userRepository,
    this.uid,
  ) : super(ConversationInitial(<Conversation>[])) {
    _conversationSubscription = _messageRepository
        .streamAllConversations(uid)
        .listen(_mapConversationStreamToEvent);
  }
  final MessageRepository _messageRepository;
  // final FirestoreUserRepository _userRepository;
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
      // final names = await _parentsRepository
      //     .convertParticipantListToNames(conversation.participants);
      // final idFrom = await _parentsRepository
      //     .getParentFirstLastName(conversation.lastMessage.idFrom);
      // final idTo = await _parentsRepository
      //     .getParentFirstLastName(conversation.lastMessage.idTo);
      // final _otherParticipant =
      //     conversation.participants.firstWhere((id) => id != uid);
      // final idFrom = names[conversation.lastMessage.idFrom];
      // updatedConversations.add(conversation.copyWith(
      //     lastMessage: conversation.lastMessage.copyWith(
      //   id: names[_otherParticipant],
      //   idFrom: names[conversation.lastMessage.idFrom],
      //   idTo: names[conversation.lastMessage.idTo],
      // )));
    }
    return ConversationSuccess(event.conversations);
  }

  // ConversationState _mapConversationRead(ConversationRead event) {
  //   assert(state.conversations.length > event.index);
  //   Conversation convoToUpdate = state.conversations[event.index];
  //   var _updatedConvoList = <Conversation>[
  //     for (Conversation convo in state.conversations) convo
  //   ];
  //   _updatedConvoList[event.index] = _updatedConvoList[event.index].copyWith(
  //       lastMessage:
  //           _updatedConvoList[event.index].lastMessage.copyWith(read: true));
  //   return ConversationSuccess(_updatedConvoList);
  // }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
