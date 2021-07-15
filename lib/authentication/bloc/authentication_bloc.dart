import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:users_repository/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required FirestoreParentsRepository firestoreParentsRepository})
      : _authenticationRepository = authenticationRepository,
        _firestoreParentsRepository = firestoreParentsRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(authenticationRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
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
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    } else if (event is AuthenticationParentAuthenticated) {
      yield AuthenticationState.parent(event.parent);
    } else if (event is AuthenticationNewParentJoined) {
      yield AuthenticationState.newParent(event.parent);
    }
  }

  AuthenticationState _mapUserChangedToState(AuthenticationUserChanged event, AuthenticationState state) {
    return event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }

  Future<void> _convertToFirestoreUser(User user) async {
    /// check if teacher is added, if the user is not a teacher, than we know they are a parent/new-parent

    if (user.isEmpty) {
      add(AuthenticationUserChanged(user));
    } else {
      Parent currUser =
          await _firestoreParentsRepository.getUserOrDefault(user.id);

      /// if user hasn't setup their account, send them to sign in page
      if (currUser == Parent.empty) {
        add(AuthenticationNewParentJoined(Parent(
            id: user.id,
            email: user.email,
            joinDate: DateTime.now().toString())));
      } else {
        add(AuthenticationParentAuthenticated(currUser));
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
