import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_repository/event_repository.dart';

/// Do a query to find all the locations the user is subscribed to,
/// Do a query t

class EventRepository {
  final eventCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('events')
      .collection('events');

  Future<void> addNewEvent(FirestoreEvent event) async {
    final docRef = eventCollection.doc();
    await eventCollection
        .add(event.copyWith(eventUID: docRef.id).toEntity().toDocument());
  }

  Future<void> deleteEvent(FirestoreEvent event) async {
    final possibleEvent = await eventCollection.doc(event.eventUID).get();
    if (possibleEvent.exists) {
      await eventCollection.doc(event.eventUID).delete();
    } else {
      print('Document does not exist. Message is from deleteEvent');
    }
  }

  /// maybe a try catch and only 1 operation would be better?
  Future<void> updateEvent(FirestoreEvent event) async {
    final possibleEvent = await eventCollection.doc(event.eventUID).get();
    if (possibleEvent.exists) {
      await eventCollection
          .doc(event.eventUID)
          .update(event.toEntity().toDocument());
    } else {
      print('Document does not exist. Message is from updateEvent');
    }
  }
}
