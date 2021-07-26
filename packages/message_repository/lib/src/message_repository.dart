import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_repository/message_repository.dart';

class MessageRepository {
  final messageCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('conversations')
      .collection('conversations');

  Future<void> addNewMessage(Message message) async {
    assert(message.conversationId.isNotEmpty);
    final docRef = messageCollection
        .doc(message.conversationId)
        .collection(message.conversationId)
        .doc();
    Message messageWithNewId = message.copyWith(id: docRef.id);
    docRef.set(messageWithNewId.toEntity().toDocument());
  }

  Future<void> deleteMessage(Message message) async {
    assert(message.conversationId.isNotEmpty);
    assert(message.id.isNotEmpty);
    try {
      await messageCollection
          .doc(message.conversationId)
          .collection(message.conversationId)
          .doc(message.id)
          .delete();
    } catch (e) {
      print('ERROR in message_repository.dart');
      print('message was $message');
      print(e);
      throw (e);
    }

    return messageCollection.doc(message.id).delete();
  }

  Stream<List<Conversation>> streamAllConversations(String uid) {
    try {
      if (uid.isEmpty) {
        print("ERROR. streamConverations(String uid) UID IS EMPTY");
        throw (StackTrace.current);
      }
      return messageCollection
          .orderBy('lastMessage.timestamp', descending: true)
          .where('participants', arrayContains: uid)
          .snapshots()
          .map((QuerySnapshot queryResults) => queryResults.docs
              .map((DocumentSnapshot snap) => Conversation.fromEntity(
                  ConversationEntity.fromSnapshot(snap)))
              .toList());
    } catch (e) {
      print("ERROR Occured in message_repository.dart");
      print("String uid: $uid");
      print(StackTrace.current);
      print(e);
      throw (e);
    }
  }

  // Stream<List<Conversation>> streamAsyncAllConversations(String uid) {
  //   final collection = messageCollection
  //       .orderBy('lastMessage.timestamp', descending: true)
  //       .where('participants', arrayContains: uid);

  //   return collection
  //       .snapshots()
  //       .asyncMap((query) => _processConversationQuery(uid, query));
  // }

  // Future<List<Conversation>> _processConversationQuery(
  //     String uid, QuerySnapshot<Map<String, dynamic>> query) async {
  //   return await Future.wait(
  //       query.docs.map((doc) => _processIndividualConversation(uid, doc)));
  // }

  // Future<Conversation> _processIndividualConversation(
  //     String uid, QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
  //   Conversation conversation =
  //       Conversation.fromEntity(ConversationEntity.fromSnapshot(doc));

  // }

  Stream<List<Message>> streamSingleConversation(Conversation conversation) {
    assert(conversation.id.isNotEmpty);
    try {
      return messageCollection
          .doc(conversation.id)
          .collection(conversation.id)
          .orderBy('timestamp')
          .snapshots()
          .map((allMessages) => allMessages.docs
              .map((snap) =>
                  Message.fromEntity(MessageEntity.fromSnapshot(snap)))
              .toList());
    } catch (e) {
      print('ERROR within message_repository.dart');
      print('conversation was $conversation');
      print(e);
      throw (e);
    }
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

  Future<void> updateMessagesRead(List<Message> messages) async {
    assert(messages.length > 0);
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (Message message in messages) {
      batch.set(
          messageCollection
              .doc(message.conversationId)
              .collection(message.conversationId)
              .doc(message.id),
          <String, bool>{'read': true},
          SetOptions(merge: true));
    }
    batch.set(
        messageCollection.doc(messages[0].conversationId),
        {
          'lastMessage': {'read': true}
        },
        SetOptions(merge: true));
    batch.commit();
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
        id: message.conversationId,
        lastMessage: message,
        participants: [message.idTo, message.idFrom]);
    await updateConversationPreview(conversation);
  }

  Future<void> updateConversationPreview(Conversation conversation) async {
    await messageCollection
        .doc(conversation.id)
        .set(conversation.toEntity().toDocument(), SetOptions(merge: true));
  }

  Future<void> startNewConversation(Conversation conversation) async {
    try {
      await messageCollection.doc(conversation.id).set(
          conversation.toEntity().toDocumentForConversationInitialization());
      await sendMessage(conversation.lastMessage);
    } catch (e) {
      print('ERROR inside message_repository.dart');
      print(e);
      throw e;
    }
  }
}
