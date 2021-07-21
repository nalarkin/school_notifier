import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_repository/message_repository.dart';

class MessageRepository {
  final messageCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('conversations')
      .collection('conversations');

  Future<void> addNewMessage(Message message) {
    return messageCollection
        .doc(message.id)
        .set((message.toEntity().toDocument()));
  }

  Future<void> deleteMessage(Message message) async {
    return messageCollection.doc(message.id).delete();
  }

  Stream<List<Message>> users() {
    return messageCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromEntity(MessageEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateMessage(Message message) async {
    await messageCollection
        .doc(message.conversationId)
        .collection(message.conversationId)
        .doc(message.id)
        .set(message.toEntity().toDocument(), SetOptions(merge: true));
  }

  Future<void> updateMessageRead(Message message) async {
    await messageCollection
        .doc(message.conversationId)
        .collection(message.conversationId)
        .doc(message.id)
        .set(<String, bool>{'read': true}, SetOptions(merge: true));
  }

  Future<void> sendMessage(Message message) async {
    try {
      await updateLastMessage(message);
      await addNewMessage(message);
    } catch (e) {
      print('ERROR inside message_repository.dart');
      print(e);
      throw e;
    }
  }

  Future<void> updateLastMessage(Message message) async {
    final conversation = Conversation(
        id: message.conversationId, lastMessage: message, userIds: []);
    await updateConversationPreview(conversation);
  }

  Future<void> updateConversationPreview(Conversation conversation) async {
    await messageCollection
        .doc(conversation.id)
        .set(conversation.toEntity().toDocument(), SetOptions(merge: true));
  }
}
