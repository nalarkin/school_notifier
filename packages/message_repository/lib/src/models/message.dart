import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class Message extends Equatable {
  const Message(
      {this.id = '',
      this.conversationId = '',
      required this.content,
      required this.idFrom,
      required this.idTo,
      this.mediaUrl = '',
      required this.timestamp,
      this.read = false});

  final String id;
  final String conversationId;
  final String content;
  final String idFrom;
  final String idTo;
  final String mediaUrl;
  final DateTime timestamp;
  final bool read;

  Message copyWith({
    String? id,
    String? conversationId,
    String? content,
    String? idFrom,
    String? idTo,
    String? mediaUrl,
    DateTime? timestamp,
    bool? read,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      content: content,
      idFrom: idFrom,
      idTo: idTo,
      mediaUrl: mediaUrl,
      timestamp: timestamp,
      read: read,
    );
  }

  static Message fromEntity(MessageEntity entity) {
    return Message(
      id: entity.id,
      conversationId: entity.conversationId,
      content: entity.content,
      idFrom: entity.idFrom,
      idTo: entity.idTo,
      mediaUrl: entity.mediaUrl,
      timestamp: entity.timestamp,
      read: entity.read,
    );
  }

  static String getConvoID(String firstId, String secondId) {
    return firstId.hashCode <= secondId.hashCode
        ? '${firstId}_$secondId'
        : '${secondId}_$firstId';
  }

  @override
  String toString() {
    return 'Message {convoId: $conversationId, id: $id, content: $content, idFrom: '
    '$idFrom,  idTo: $idTo mediaUrl: $mediaUrl, timestamp: $timestamp, read: $read } ';
  }

  @override
  List<Object> get props => [id, content, idFrom, idTo, mediaUrl, timestamp, read];

  bool get isEmpty => this == Message.empty;
  bool get isNotEmpty => this != Message.empty;

  static final empty = Message(
      id: '',
      conversationId: '',
      content: '',
      idFrom: '',
      idTo: '',
      mediaUrl: '',
      timestamp: DateTime.fromMicrosecondsSinceEpoch(1626835721000),
      read: false);
}
