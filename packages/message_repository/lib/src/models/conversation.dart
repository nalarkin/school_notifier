import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class Conversation extends Equatable {
  const Conversation(
      {required this.id, required this.userIds, required this.lastMessage});

  final String id;
  final List<dynamic> userIds;
  // final Map<dynamic, dynamic> lastMessage;
  final Message lastMessage;

  Conversation copyWith({
    String? id,
    List<dynamic>? userIds,
    Message? lastMessage,
  }) {
    return Conversation(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  String toString() {
    return 'Conversation { id: $id, userIds: $userIds, lastMessage:'
        ' $lastMessage}';
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      userIds: userIds,
      lastMessage: lastMessage.toEntity().toJson(),
    );
  }

  static Conversation fromEntity(ConversationEntity entity) {
    return Conversation(
      id: entity.id,
      userIds: entity.userIds,
      lastMessage:
          Message.fromEntity(MessageEntity.fromJson(entity.lastMessage)),
    );
  }

  bool get isEmpty => this == Conversation.empty;
  bool get isNotEmpty => this != Conversation.empty;

  @override
  List<Object> get props => [id, userIds, lastMessage];

  static final empty =
      Conversation(id: '', userIds: [], lastMessage: Message.empty);
}
