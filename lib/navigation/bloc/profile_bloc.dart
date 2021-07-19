import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_notifier/profile/parent/bloc/parent_profile_bloc.dart';
import 'package:users_repository/users_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._authBloc, this.parentsRepository, this.teachersRepository)
      : super(ProfileState.unknown()) {
    _authBlocSubscription =
        _authBloc.stream.listen(_mapAuthenticationStateToProfileEvent);
  }

  final AuthenticationBloc _authBloc;
  late StreamSubscription _authBlocSubscription;
  final FirestoreParentsRepository parentsRepository;
  final TeachersRepository teachersRepository;
  // final StudentsRepository studentRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileParentSignedIn) {
      yield await _mapProfileParentSignedInToState(event);
    } else if (event is ProfileStarted) {
      yield await _mapProfileStartedToState(event);
    } else if (event is ProfileNewParent) {
      yield await _mapProfileNewParentState(event);
    } else if (event is ProfileUnknown) {
      yield ProfileState.unknown();
    } else if (event is ProfileFailed) {
      yield ProfileState.failure();
    } else if (event is ProfileNewParentCompleted) {
      
    }
  }

  Future<ProfileState> _mapProfileParentSignedInToState(
      ProfileParentSignedIn event) async {
    // await Future.delayed(Duration(seconds: 0));
    return ProfileState.parent(event.parent ?? Parent.empty);
  }

  Future<ProfileState> _mapProfileStartedToState(ProfileStarted event) async {
    // await Future.delayed(Duration(seconds: 0));
    return ProfileState.unknown();
  }

  Future<ProfileState> _mapProfileParentCompletedToState(
      ProfileNewParentCompleted event) async {
    // await Future.delayed(Duration(seconds: 0));
    Parent? currParent = event.parent;
    if (currParent != null) {
      await parentsRepository.addNewUser(event.parent as Parent);
      return ProfileState.parent(currParent);
    }
    print('Parent after setup was null. Could not create Parent in firestore.');
    return ProfileState.failure();
  }

  Future<ProfileState> _mapProfileNewParentState(ProfileNewParent event) async {
    // await Future.delayed(Duration(seconds: 0));
    if (event.parent != null) {
      return ProfileState.newParent(event.parent as Parent);
    }
    return ProfileState.newParent(Parent(id: 'FAILED TO PARENT'));
    // return ProfileState.newParent(event.user ?? User.empty);
  }

  Future<void> _mapAuthenticationStateToProfileEvent(
      AuthenticationState appState) async {
    if (appState.status == AuthenticationStatus.authenticated) {
      _findUserRole(appState);
    }

    if (appState.status == AuthenticationStatus.parent) {
      add(ProfileParentSignedIn(parent: appState.parent, user: appState.user));
    } else if (appState.status == AuthenticationStatus.newParent) {
      add(ProfileNewParent(parent: appState.parent, user: appState.user));
    } else if (appState.status == AuthenticationStatus.unauthenticated) {
      add(ProfileUnknown());
    }
  }

  Future<void> _findUserRole(AuthenticationState appState) async {
    final userID = appState.user.id;

    Parent? possibleParent = await parentsRepository.getParentIfExists(userID);
    if (possibleParent != null) {
      add(ProfileParentSignedIn(parent: possibleParent));
      return null;
    }
    Teacher? possibleTeacher =
        await teachersRepository.getTeacherIfExists(userID);
    if (possibleTeacher != null) {
      add(ProfileTeacherSignedIn(teacher: possibleTeacher));
      return null;
    }
    add(ProfileNewParent(
        parent: Parent(id: userID, email: appState.user.email)));
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
