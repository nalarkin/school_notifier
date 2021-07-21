import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class Conversation extends Equatable {
  const Conversation(
      {required this.id, required this.participants, required this.lastMessage});

  final String id;
  final List<String> participants;
  // final Map<dynamic, dynamic> lastMessage;
  final Message lastMessage;

  Conversation copyWith({
    String? id,
    List<String>? participants,
    Message? lastMessage,
  }) {
    return Conversation(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  String toString() {
    return 'Conversation { id: $id, participants: $participants, lastMessage:'
        ' $lastMessage}';
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      participants: participants,
      lastMessage: lastMessage.toEntity().toJson(),
    );
  }

  static Conversation fromEntity(ConversationEntity entity) {
    return Conversation(
      id: entity.id,
      participants: List<String>.from(entity.participants),
      lastMessage:
          Message.fromEntity(MessageEntity.fromJson(entity.lastMessage)),
    );
  }

  bool get isEmpty => this == Conversation.empty;
  bool get isNotEmpty => this != Conversation.empty;

  @override
  List<Object> get props => [id, participants, lastMessage];

  static final empty =
      Conversation(id: '', participants: [], lastMessage: Message.empty);
}
