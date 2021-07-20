import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_notifier/profile/parent/bloc/parent_profile_bloc.dart';
import 'package:users_repository/users_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(
      this._authBloc, this.parentsRepository, this.teachersRepository)
      : super(NavigationState.unknown()) {
    _authBlocSubscription =
        _authBloc.stream.listen(_mapAuthenticationStateToProfileEvent);
  }

  final AuthenticationBloc _authBloc;
  late StreamSubscription _authBlocSubscription;
  final FirestoreParentsRepository parentsRepository;
  final TeachersRepository teachersRepository;
  // final StudentsRepository studentRepository;

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationParentSignedIn) {
      yield await _mapProfileParentSignedInToState(event);
    } else if (event is NavigationStarted) {
      yield await _mapProfileStartedToState(event);
    } else if (event is NavigationNewParent) {
      yield await _mapProfileNewParentState(event);
    } else if (event is NavigationUnknown) {
      yield NavigationState.unknown();
    } else if (event is NavigationFailed) {
      yield NavigationState.failure();
    } else if (event is NavigationNewParentCompleted) {}
  }

  Future<NavigationState> _mapProfileParentSignedInToState(
      NavigationParentSignedIn event) async {
    // await Future.delayed(Duration(seconds: 0));
    return NavigationState.parent(event.parent ?? Parent.empty);
  }

  Future<NavigationState> _mapProfileStartedToState(
      NavigationStarted event) async {
    // await Future.delayed(Duration(seconds: 0));
    return NavigationState.unknown();
  }

  Future<NavigationState> _mapProfileParentCompletedToState(
      NavigationNewParentCompleted event) async {
    // await Future.delayed(Duration(seconds: 0));
    Parent? currParent = event.parent;
    if (currParent != null) {
      await parentsRepository.addNewUser(event.parent as Parent);
      return NavigationState.parent(currParent);
    }
    print('Parent after setup was null. Could not create Parent in firestore.');
    return NavigationState.failure();
  }

  Future<NavigationState> _mapProfileNewParentState(
      NavigationNewParent event) async {
    // await Future.delayed(Duration(seconds: 0));
    if (event.parent != null) {
      return NavigationState.newParent(event.parent as Parent);
    }
    return NavigationState.newParent(Parent(id: 'FAILED TO PARENT'));
    // return NavigationState.newParent(event.user ?? User.empty);
  }

  Future<void> _mapAuthenticationStateToProfileEvent(
      AuthenticationState appState) async {
    if (appState.status == AuthenticationStatus.authenticated) {
      _findUserRole(appState);
    }

    if (appState.status == AuthenticationStatus.parent) {
      add(NavigationParentSignedIn(
          parent: appState.parent, user: appState.user));
    } else if (appState.status == AuthenticationStatus.newParent) {
      add(NavigationNewParent(parent: appState.parent, user: appState.user));
    } else if (appState.status == AuthenticationStatus.unauthenticated) {
      add(NavigationUnknown());
    }
  }

  Future<void> _findUserRole(AuthenticationState appState) async {
    final userID = appState.user.id;

    Parent? possibleParent = await parentsRepository.getParentIfExists(userID);
    if (possibleParent != null) {
      add(NavigationParentSignedIn(parent: possibleParent));
      return null;
    }
    Teacher? possibleTeacher =
        await teachersRepository.getTeacherIfExists(userID);
    if (possibleTeacher != null) {
      add(NavigationTeacherSignedIn(teacher: possibleTeacher));
      return null;
    }
    add(NavigationNewParent(
        parent: Parent(id: userID, email: appState.user.email)));
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
