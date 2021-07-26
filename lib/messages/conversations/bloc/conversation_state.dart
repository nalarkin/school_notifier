part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState({required this.conversations});

  final List<Conversation> conversations;

  @override
  List<Object> get props => [conversations];
}

class ConversationInitial extends ConversationState {
  const ConversationInitial(conversations)
      : super(conversations: conversations);

  @override
  String toString() {
    return 'ConversationInitial { conversations: ${this.conversations}}';
  }
}

class ConversationSuccess extends ConversationState {
  const ConversationSuccess(conversations)
      : super(conversations: conversations);

  @override
  String toString() {
    return 'ConversationSuccess { conversations: ${this.conversations}}';
  }
}

class ConversationFailure extends ConversationState {
  const ConversationFailure(conversations, this.errorMessage)
      : super(conversations: conversations);
  final String errorMessage;

  @override
  String toString() {
    return 'ConversationFailure { errorMessage: $errorMessage, '
        'conversations: ${this.conversations}}';
  }
}
