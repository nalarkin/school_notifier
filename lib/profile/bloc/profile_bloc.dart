import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:users_repository/users_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._userRepository, this._navigationBloc)
      : super(ProfileInitial()) {
    _profileStream = _userRepository
        .liveProfileStream(_navigationBloc.state.user.id)
        .listen(_mapProfile);
    _navigationStream =
        _navigationBloc.stream.listen(_mapNavigationStateToProfileEvent);
  }

  final FirestoreUserRepository _userRepository;
  final NavigationBloc _navigationBloc;
  late StreamSubscription _profileStream;
  late StreamSubscription _navigationStream;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileChanged) {
      yield _mapProfileChangedToState(event);
    }
  }

  ProfileState _mapProfileChangedToState(ProfileChanged curr) {
    return ProfileSuccess(curr.user);
  }

  void _mapProfile(FirestoreUser currUser) {
    add(ProfileChanged(currUser));
  }

  Future<void> _mapNavigationStateToProfileEvent(
      NavigationState navState) async {
    _profileStream.cancel();
    if (navState.user.id.isNotEmpty) {
      _profileStream = _userRepository
          .liveProfileStream(navState.user.id)
          .listen(_mapProfile);
    }
    return null;
  }

  @override
  Future<void> close() {
    _profileStream.cancel();
    _navigationStream.cancel();
    return super.close();
  }
}
