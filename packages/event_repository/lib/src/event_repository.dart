import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_repository/event_repository.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<List<FirestoreEvent>> _individualSubscriptionList(
      String subscriptionID) {
    return eventCollection
        .where('eventSubscriptionID', isEqualTo: subscriptionID)
        .snapshots()
        .map((event) => event.docs
            .map((snap) =>
                FirestoreEvent.fromEntity(EventEntity.fromSnapshot(snap)))
            .toList());
  }

  // CombineLatestStream<List<FirestoreEvent>> getAllSubscribedEvents(
  //     List<String> subscriptionIDList) {
  //   return CombineLatestStream( 
  //     [
  //     for (var subID in subscriptionIDList) _individualSubscriptionList(subID)
  //   ]
  //   ).listen(print);
  // }
//  List<Stream<List<FirestoreEvent>>> getAllSubscribedEvents(
//       List<String> subscriptionIDList) {
//     return <Stream<List<FirestoreEvent>>>[
//       for (var subID in subscriptionIDList) _individualSubscriptionList(subID)
//     ];
//   }
  Stream<List<FirestoreEvent>> getAllSubscribedEvents(
      List<String> subscriptionIDList) {
    return MergeStream(<Stream<List<FirestoreEvent>>>[
      for (var subID in subscriptionIDList) _individualSubscriptionList(subID)
    ]);
  }

  Stream<List<FirestoreEvent>> getSingleStream(String subID) {
    print("getSingleStream called with arg $subID");
    return eventCollection
        .where('eventSubscriptionID', isEqualTo: subID)
        .snapshots()
        .map(_convertToEventList);
  }

  // Stream<List<FirestoreEvent>> getSingleStream(String subID) {
  //   print("getSingleStream called with arg $subID");
  //   return eventCollection
  //       .where('eventSubscriptionID', isEqualTo: subID)
  //       .snapshots()
  //       .map(_convertToEventList);
  // }

  List<FirestoreEvent> _convertToEventList(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print('_convertToEventList() called');
    var _eventList = <FirestoreEvent>[];
    snapshot.docs.forEach((snap) {
      _eventList.add(FirestoreEvent.fromEntity(EventEntity.fromSnapshot(snap)));
    });
    print('Created event list is: $_eventList');
    return _eventList;
  }
}
