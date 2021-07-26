part of 'message_bloc.dart';

enum MessageStatus { initial, success, failure, first }

class MessageState extends Equatable {
  const MessageState({required this.status, this.messages = const <Message>[]});

  final MessageStatus status;
  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}
