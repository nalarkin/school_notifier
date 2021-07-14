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
      required FirestoreParentsRepository firestoreParentsRepository})
      : _authenticationRepository = authenticationRepository,
        _firestoreParentsRepository = firestoreParentsRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  final FirestoreParentsRepository _firestoreParentsRepository;
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
    } else if (event is AppParentAuthenticated) {
      yield AppState.parent(event.parent);
    } else if (event is AppNewParentJoined) {
      yield AppState.newParent(event.parent);
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated();
  }

  Future<void> _convertToFirestoreUser(User user) async {
    /// check if teacher is added, if the user is not a teacher, than we know they are a parent/new-parent

    if (user.isEmpty) {
      add(AppUserChanged(user));
    } else {
      Parent currUser =
          await _firestoreParentsRepository.getUserOrDefault(user.id);

      /// if user hasn't setup their account, send them to sign in page
      if (currUser == Parent.empty) {
        add(AppNewParentJoined(Parent(
            id: user.id,
            email: user.email,
            joinDate: DateTime.now().toString())));
      } else {
        add(AppParentAuthenticated(currUser));
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
