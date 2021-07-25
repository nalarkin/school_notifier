part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageStarted extends MessageEvent {}

class MessageSentText extends MessageEvent {
  const MessageSentText(this.content) : super ();
  final String content;

  @override
  List<Object> get props => [content];
}
class MessageStartFirstConversation extends MessageEvent {
  const MessageStartFirstConversation(this.content) : super ();
 final String content;

  @override
  List<Object> get props => [content];
}
class MessageLoaded extends MessageEvent {
  const MessageLoaded(this.messages) : super ();
  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}
