import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  const ConversationEntity(
      {required this.id,
      required this.participants,
      required this.lastMessage});

  final String id;
  final List<dynamic> participants;
  final Map<String, dynamic> lastMessage;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
    };
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
    };
  }

  static ConversationEntity fromJson(Map<String, Object?> json) {
    return ConversationEntity(
      id: json['id'] as String,
      participants: json['participants'] as List<String>,
      lastMessage: json['lastMessage'] as Map<String, dynamic>,
    );
  }

  static ConversationEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return ConversationEntity(
      id: snap.id,
      participants: data['participants'] as List<dynamic>,
      lastMessage: data['lastMessage'] as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'ConversationEntity { id: $id, participants: $participants, lastMessage:'
        ' $lastMessage}';
  }

  @override
  List<Object> get props => [id, participants, lastMessage];

  static const empty =
      ConversationEntity(id: '', participants: [], lastMessage: {});
}
