import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:users_repository/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
      {required AuthenticationRepository authenticationRepository,
      required FirestoreUsersRepository firestoreUsersRepository})
      : _authenticationRepository = authenticationRepository,
        _firestoreUsersRepository = firestoreUsersRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  final FirestoreUsersRepository _firestoreUsersRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) async {
    await _convertToFirestoreUser(user);
  }
  // add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AppLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated();
  }

  Future<void> _convertToFirestoreUser(User user) async {
    FirestoreUser currUser =
        await _firestoreUsersRepository.getUserOrDefault(user.id);
    if (currUser == FirestoreUser.empty)
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
