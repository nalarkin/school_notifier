import 'package:event_repository/event_repository.dart';

import 'package:rxdart/rxdart.dart';

class EventViewModel {
  EventViewModel({required this.database});
  final EventRepository database;
          // .getAllSubscribedEvents(['eventSubId', 'eventSubId2']),

  /// returns the entire movies list with user-favourite information
  Stream<List<FirestoreEvent>> combineToStream() {
    return Rx.combineLatest2(
        database.getSingleStream('eventSubId'), database.getSingleStream('eventSubId2'),
        (List<FirestoreEvent> movies, List<FirestoreEvent> userFavourites) {
      return(movies + userFavourites);
    });
    // return Rx.combineLatest2(
    //     database.moviesStream(), database.userFavouritesStream(),
    //     (List<Movie> movies, List<UserFavourite> userFavourites) {
    //   return movies.map((movie) {
    //     final userFavourite = userFavourites?.firstWhere(
    //         (userFavourite) => userFavourite.movieId == movie.id,
    //         orElse: () => null);
    //     return MovieUserFavourite(
    //       movie: movie,
    //       isFavourite: userFavourite?.isFavourite ?? false,
    //     );
    //   }).toList();
    // });
  }
}
