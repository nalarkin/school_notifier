part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent({this.conversations = const <Conversation>[]});
  final List<Conversation> conversations;

  @override
  List<Object> get props => [conversations];
}

class ConversationStarted extends ConversationEvent {
  const ConversationStarted(conversations)
      : super(conversations: conversations);

  @override
  String toString() {
    return 'ConversationStarted { conversations: ${this.conversations}}';
  }
}

class ConversationLoaded extends ConversationEvent {
  const ConversationLoaded(conversations) : super(conversations: conversations);

  @override
  String toString() {
    return 'ConversationLoaded { conversations: ${this.conversations}}';
  }
}

// class ConversationRead extends ConversationEvent {
//   const ConversationRead(this.singleConversation, this.index) : super();
//   final Conversation singleConversation;
//   final int index;

//   @override
//   String toString() {
//     return 'ConversationRead { singleConversation: ${this.singleConversation}}';
//   }
// }
