import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(this._messageRepository, this._conversation, this._viewerUid)
      : super(MessageState(status: MessageStatus.initial)) {
    _otherParticipant =
        _conversation.participants.firstWhere((id) => id != _viewerUid);
    _conversationSubscription = _messageRepository
        .streamSingleConversation(_conversation)
        .listen(_mapStreamToState);
  }

  final MessageRepository _messageRepository;
  final Conversation _conversation;
  late StreamSubscription _conversationSubscription;
  final String _viewerUid;
  late String _otherParticipant;

  void _mapStreamToState(List<Message> messages) {
    add(MessageLoaded(messages));
  }

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is MessageLoaded) {
      yield MessageState(
          status: MessageStatus.success, messages: event.messages);
    } else if (event is MessageSentText) {
      unawaited(_mapMessageSent(event));
    }
  }

  Future<void> _mapMessageSent(MessageSentText event) async {
    final content = event.content;
    final Message _newMessage = Message(
      idFrom: _viewerUid,
      idTo: _otherParticipant,
      conversationId: _conversation.id,
      content: content,
      timestamp: DateTime.now(),
    );
    await _messageRepository.sendMessage(_newMessage);
  }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
