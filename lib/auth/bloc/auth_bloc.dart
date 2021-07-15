import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/app/app.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._appBloc) : super(AuthInitial()) {
    _appBlocSubscription = _appBloc.stream.listen(_mapAppBlocStateToAuthEvent);
  }

  final AppBloc _appBloc;
  late StreamSubscription _appBlocSubscription;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthParentSignedIn) {
      yield await _mapAuthParentSignedInToState(event);
    } else if (event is AuthStarted) {
      yield await _mapAuthStartedToState(event);
    } else if (event is AuthNewParent) {
      yield await _mapAuthNewParentState(event);
    }
  }

  Future<AuthParentSignInSuccess> _mapAuthParentSignedInToState(
      AuthParentSignedIn event) async {
    // await Future.delayed(Duration(seconds: 0));
    return AuthParentSignInSuccess(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<AuthInitial> _mapAuthStartedToState(AuthStarted event) async {
    // await Future.delayed(Duration(seconds: 0));
    return AuthInitial(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<AuthNewParentSetup> _mapAuthNewParentState(AuthNewParent event) async {
    // await Future.delayed(Duration(seconds: 0));
    return AuthNewParentSetup(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<void> _mapAppBlocStateToAuthEvent(AppState appState) async {
    if (appState.status == AppStatus.parent) {
      add(AuthParentSignedIn(parent: appState.parent, user: appState.user));
    } else if (appState.status == AppStatus.newParent) {
      add(AuthNewParent(parent: appState.parent, user: appState.user));
    } else {
      add(AuthStarted(user: appState.user, parent: appState.parent));
    }
  }

  @override
  Future<void> close() {
    _appBlocSubscription.cancel();
    return super.close();
  }
}
