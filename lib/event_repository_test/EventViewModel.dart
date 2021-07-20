import 'package:event_repository/event_repository.dart';

import 'package:rxdart/rxdart.dart';

class EventViewModel {
  EventViewModel({required this.database});
  final EventRepository database;
  // .getAllSubscribedEvents(['eventSubId', 'eventSubId2']),

  /// returns the entire movies list with user-favourite information
  // Stream<List<FirestoreEvent>> combineToStream() {
  //   return Rx.combineLatest2(database.getSingleStream('eventSubId'),
  //       database.getSingleStream('eventSubId2'),
  //       (List<FirestoreEvent> movies, List<FirestoreEvent> userFavourites) {
  //     return (movies + userFavourites);
  //   });
  // }

  Stream<List<FirestoreEvent>> combineAllStreams() {

    return Rx.combineLatest([
      database.getSingleStream('eventSubId'),
      database.getSingleStream('eventSubId2')
    ], (List<List<FirestoreEvent>> values) {
      var _res = <FirestoreEvent>[];
      for (List<FirestoreEvent> val in values) {
        _res.addAll(val);
      }
      return _res;
    });
  }
}
