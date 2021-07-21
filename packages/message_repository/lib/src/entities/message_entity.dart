import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class MessageEntity extends Equatable {
  const MessageEntity(
      {required this.id,
      required this.content,
      required this.idFrom,
      required this.idTo,
      required this.mediaUrl,
      required this.timestamp});

  final String id;
  final String content;
  final String idFrom;
  final String idTo;
  final String mediaUrl;
  final DateTime timestamp;

  MessageEntity copyWith({
    String? id,
    String? content,
    String? idFrom,
    String? idTo,
    String? mediaUrl,
    DateTime? timestamp,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp,
    };
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'content': content,
      'idFrom': idFrom,
      'idTo': idTo,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp,
    };
  }

  static MessageEntity fromJson(Map<String, Object> json) {
    return MessageEntity(
      id: json['id'] as String,
      content: json['content'] as String,
      idFrom: json['idFrom'] as String,
      idTo: json['idTo'] as String,
      mediaUrl: json['mediaUrl'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  static MessageEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return MessageEntity(
      id: snap.id,
      content: data['content'] as String,
      idFrom: data['idFrom'] as String,
      idTo: data['idTo'] as String,
      mediaUrl: data['mediaUrl'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  static Message fromEntity(MessageEntity entity) {
    return Message(
      id: entity.id,
      content: entity.content,
      idFrom: entity.idFrom,
      idTo: entity.idTo,
      mediaUrl: entity.mediaUrl,
      timestamp: entity.timestamp,
    );
  }

  @override
  String toString() {
    return 'MessageEntity { id: $id, content: $content, idFrom: $idFrom, '
        'idTo: $idTo mediaUrl: $mediaUrl, timestamp: $timestamp } ';
  }

  @override
  List<Object> get props => [id, content, idFrom, idTo, mediaUrl, timestamp];
}
