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
    _otherParticipant = _conversation.participants.firstWhere(
        (id) => id != _viewerUid,
        orElse: () => _conversation.participants[0]);
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
      yield _mapMessageLoadedToState(event);
    } else if (event is MessageSentText) {
      unawaited(_mapMessageSent(event));
    } else if (event is MessageStartFirstConversation) {
      unawaited(_mapFirstMessage(event));
    }
  }

  MessageState _mapMessageLoadedToState(MessageLoaded event) {
    if (event.messages.length > 0) {
      // if most recent message hasn't been read, update all messages that
      // are marked as unread.
      if (!event.messages.last.read) {
        var _unreadMessages = <Message>[];
        for (var i = event.messages.length - 1; i >= 0; i--) {
          if (event.messages[i].read) break;
          if (event.messages[i].idTo == _viewerUid) {
            _unreadMessages.add(event.messages[i]);
          }
        }

        // batch write
        if (_unreadMessages.length > 0) {
          _messageRepository.updateMessagesRead(_unreadMessages);
        }
      }
      return MessageState(
          status: MessageStatus.success, messages: event.messages);
    } else {
      return MessageState(status: MessageStatus.first);
    }
  }

  Future<void> _mapMessageSent(MessageSentText event) async {
    final content = event.content.trim();
    final Message _newMessage = Message(
      idFrom: _viewerUid,
      idTo: _otherParticipant,
      conversationId: _conversation.id,
      content: content,
      timestamp: DateTime.now(),
    );
    await _messageRepository.sendMessage(_newMessage);
  }

  Future<void> _mapFirstMessage(MessageStartFirstConversation event) async {
    final content = event.content.trim();
    final Message _newMessage = Message(
      idFrom: _viewerUid,
      idTo: _otherParticipant,
      conversationId: _conversation.id,
      content: content,
      timestamp: DateTime.now(),
    );

    final newConversation = _conversation.copyWith(lastMessage: _newMessage);
    await _messageRepository.startNewConversation(newConversation);
  }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
