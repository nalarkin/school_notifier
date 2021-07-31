import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._authBloc, this._userRepository, this._keyRepository)
      : super(NavigationState.unknown()) {
    _authBlocSubscription =
        _authBloc.stream.listen(_mapAuthenticationStateToProfileEvent);
  }

  final AuthenticationBloc _authBloc;
  late StreamSubscription _authBlocSubscription;
  final FirestoreUserRepository _userRepository;
  final KeyRepository _keyRepository;

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationUserSignedIn) {
      yield await _mapUserSignInToState(event);
    } else if (event is NavigationParentSignedIn) {
      yield await _mapProfileParentSignedInToState(event);
    } else if (event is NavigationStarted) {
      yield await _mapProfileStartedToState(event);
    } else if (event is NavigationNewParent) {
      print('failure in navigation_bloc. event is $event');
      yield NavigationState.failure();
    } else if (event is NavigationUnknown) {
      yield NavigationState.unknown();
    } else if (event is NavigationFailed) {
      yield NavigationState.failure();
    } else if (event is NavigationNewParentCompleted) {
      print('failure in navigation_bloc. event is $event');
      yield NavigationState.failure();
    } else if (event is NavigationTokenAuthorized) {
      yield await _mapNewTokenToState(event);
    }
  }

  Future<NavigationState> _mapProfileParentSignedInToState(
      NavigationParentSignedIn event) async {
    return NavigationState.parent(event.user);
  }

  Future<NavigationState> _mapProfileStartedToState(
      NavigationStarted event) async {
    return NavigationState.unknown();
  }

  Future<NavigationState> _mapNewTokenToState(
      NavigationTokenAuthorized event) async {
    FirestoreKey? key = event.key;
    if (key != null && key.isValid) {
      if (key.isParent) {
        return NavigationState.newParent(key);
      } else if (key.isTeacher) {
        return NavigationState.newTeacher(key);
      } else if (key.isStudent) {
        return NavigationState.newStudent(key);
      }
    }
    return NavigationState.failure();
  }

  Future<NavigationState> _mapProfileCompletedToState(
      NavigationNewParentCompleted event) async {
    assert(event.user != FirestoreUser.empty);
    FirestoreUser user = event.user;
    try {
      await _userRepository.addNewUser(user);
      if (user.role == UserRole.parent) {
        return NavigationState.parent(user);
      } else if (user.role == UserRole.teacher) {
        return NavigationState.teacher(user);
      } else if (user.role == UserRole.student) {
        return NavigationState.student(user);
      }
    } catch (e) {
      print(
          'Parent after setup was null. Could not create Parent in firestore.');
    }
    return NavigationState.failure();
  }

  Future<void> _mapAuthenticationStateToProfileEvent(
      AuthenticationState appState) async {
    if (appState.status == AuthenticationStatus.authenticated) {
      User? authUser = appState.user;

      add(NavigationUserSignedIn(
          FirestoreUser(id: authUser.id, email: authUser.email)));
    }

    if (appState.status == AuthenticationStatus.unauthenticated) {
      add(NavigationUnknown());
    }
  }

  Future<void> _findUserRole(AuthenticationState appState) async {
    assert(appState.status == AuthenticationStatus.authenticated);
    assert(appState.user.id.isNotEmpty);
    final _userID = appState.user.id;

    FirestoreUser? _currUser =
        await _userRepository.getFirestoreUserIfExists(_userID);

    if (_currUser == null) {
      add(NavigationFailed('failed to find user in firestore'));
      return null;
    }
    if (_currUser.role == UserRole.parent) {
      add(NavigationParentSignedIn(_currUser));
    } else if (_currUser.role == UserRole.teacher) {
      add(NavigationTeacherSignedIn(_currUser));
    } else if (_currUser.role == UserRole.student) {
      add(NavigationStudentSignedIn(_currUser));
    }
  }

  Future<NavigationState> _mapUserSignInToState(
      NavigationUserSignedIn event) async {
    assert(event.user.id.isNotEmpty);
    final _userID = event.user.id;
    for (var i = 0; i < 10; i++) {
      // print('trying to grab info from firestore. #$i');
      FirestoreUser? _currUser =
          await _userRepository.getFirestoreUserIfExists(_userID);
      if (_currUser == null) {
        await Future.delayed(Duration(seconds: 2));
      } else if (_currUser.role == UserRole.parent) {
        return NavigationState.parent(_currUser);
      } else if (_currUser.role == UserRole.teacher) {
        return NavigationState.teacher(_currUser);
      } else if (_currUser.role == UserRole.student) {
        return NavigationState.student(_currUser);
      }
    }

    return NavigationState.failure();
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
