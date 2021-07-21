import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart';

class Message extends Equatable{
  const Message({required this.id, required this.content, required this.idFrom, required this.idTo, required this.mediaUrl,  required this.timestamp});


  final String id;
  final String content;
  final String idFrom;
  final String idTo;
  final String mediaUrl;
  final DateTime timestamp;

  Message copyWith({
    String? id,
    String? content,
    String? idFrom,
    String? idTo,
    String? mediaUrl,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

    MessageEntity toEntity() {
    return MessageEntity(
      id: id ,
      content: content ,
      idFrom: idFrom ,
      idTo: idTo ,
      mediaUrl: mediaUrl ,
      timestamp: timestamp ,
    );
  }

  static Message fromEntity(MessageEntity entity) {
    return Message(
      id: entity.id ,
      content: entity.content ,
      idFrom: entity.idFrom ,
      idTo: entity.idTo ,
      mediaUrl: entity.mediaUrl ,
      timestamp: entity.timestamp ,
    );
  }





  @override
  String toString() {
    return 'Message { id: $id, content: $content, idFrom: $idFrom,  idTo: '
    '$idTo mediaUrl: $mediaUrl, timestamp: $timestamp } ';
  }

  @override
  List<Object> get props => [id, content, idFrom, idTo, mediaUrl, timestamp];
}
