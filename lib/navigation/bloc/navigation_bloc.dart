import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._appBloc) : super(NavigationInitial()) {
    _appBlocSubscription = _appBloc.stream.listen(_mapAppBlocStateToAuthEvent);
  }

  final AuthenticationBloc _appBloc;
  late StreamSubscription _appBlocSubscription;

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationParentSignedIn) {
      yield await _mapAuthParentSignedInToState(event);
    } else if (event is NavigationStarted) {
      yield await _mapAuthStartedToState(event);
    } else if (event is NavigationNewParent) {
      yield await _mapAuthNewParentState(event);
    }
  }

  Future<NavigationParentSignInSuccess> _mapAuthParentSignedInToState(
      NavigationParentSignedIn event) async {
    // await Future.delayed(Duration(seconds: 0));
    return NavigationParentSignInSuccess(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<NavigationInitial> _mapAuthStartedToState(NavigationStarted event) async {
    // await Future.delayed(Duration(seconds: 0));
    return NavigationInitial(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<NavigationNewParentSetup> _mapAuthNewParentState(NavigationNewParent event) async {
    // await Future.delayed(Duration(seconds: 0));
    return NavigationNewParentSetup(
        parent: event.parent, teacher: event.teacher, user: event.user);
  }

  Future<void> _mapAppBlocStateToAuthEvent(AuthenticationState appState) async {
    if (appState.status == AuthenticationStatus.parent) {
      add(NavigationParentSignedIn(parent: appState.parent, user: appState.user));
    } else if (appState.status == AuthenticationStatus.newParent) {
      add(NavigationNewParent(parent: appState.parent, user: appState.user));
    } else {
      add(NavigationStarted(user: appState.user, parent: appState.parent));
    }
  }

  @override
  Future<void> close() {
    _appBlocSubscription.cancel();
    return super.close();
  }
}
