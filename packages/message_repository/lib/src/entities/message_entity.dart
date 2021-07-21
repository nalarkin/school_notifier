import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class MessageEntity extends Equatable {
  const MessageEntity(
      {required this.id,
      required this.conversationId,
      required this.content,
      required this.idFrom,
      required this.idTo,
      required this.mediaUrl,
      required this.timestamp,
      required this.read,
      });

  final String id;
  final String conversationId;
  final String content;
  final String idFrom;
  final String idTo;
  final String mediaUrl;
  final DateTime timestamp;
  final bool read;

  MessageEntity copyWith({
    String? id,
    String? conversationId,
    String? content,
    String? idFrom,
    String? idTo,
    String? mediaUrl,
    DateTime? timestamp,
    bool? read,
  }) {
    return MessageEntity(
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

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp,
      'read': read,
    };
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'conversationId': conversationId,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp,
      'read': read,
    };
  }

  static MessageEntity fromJson(Map<String, Object?> json) {
    return MessageEntity(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      content: json['content'] as String,
      idFrom: json['idFrom'] as String,
      idTo: json['idTo'] as String,
      mediaUrl: json['mediaUrl'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      read: json['read'] as bool,

    );
  }

  static MessageEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return MessageEntity(
      id: snap.id,
      conversationId: data['conversationId'] as String,
      content: data['content'] as String,
      idFrom: data['idFrom'] as String,
      idTo: data['idTo'] as String,
      mediaUrl: data['mediaUrl'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      read: data['read'] as bool,
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

  @override
  String toString() {
    return 'MessageEntity { convoId: $conversationId, id: $id, content: ' 
    '$content, idFrom: $idFrom, idTo: $idTo mediaUrl: $mediaUrl, timestamp: '
    '$timestamp, read: $read } ';
  }

  @override
  List<Object> get props => [id, content, idFrom, idTo, mediaUrl, timestamp, read];
}
