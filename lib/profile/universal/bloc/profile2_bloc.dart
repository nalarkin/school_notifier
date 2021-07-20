import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:school_notifier/profile/universal/stream_grabber/stream_grabber.dart';
import 'package:users_repository/users_repository.dart';

part 'profile2_event.dart';
part 'profile2_state.dart';

class Profile2Bloc extends Bloc<Profile2Event, Profile2State> {
  Profile2Bloc({
    required NavigationBloc profileBloc,
    required FirestoreParentsRepository parentsRepository,
  })  : _parentsRepository = parentsRepository,
        _profileBloc = profileBloc,
        super(Profile2Initial()) {
    _profileBlocStream = profileBloc.stream.listen(_mapProfileToStream);
    // _profileStream =
    // parentsRepository.liveProfileStream(parentId).listen(_mapParentProfile);
  }

  final FirestoreParentsRepository _parentsRepository;
  // late StreamSubscription _profileStream;
  // final String _parentId;
  late StreamSubscription _profileBlocStream;
  late NavigationBloc _profileBloc;
  var _profile2Stream;
  // var StreamGrabber _streamGrabber;

  Future<void> _mapProfileToStream(NavigationState profState) async {
    if (profState.status == NavigationStatus.parent) {
      final id = profState.parent?.id;
      if (id != null) {
        // _streamGrabber = StreamGrabber.parent(parentsRepository: _parentsRepository, id: id);
        // if (_profile2Stream.)
        _profile2Stream =
            _parentsRepository.liveProfileStream(id).listen(_mapParentProfile);
      }
    }
  }

  @override
  Stream<Profile2State> mapEventToState(
    Profile2Event event,
  ) async* {
    if (event is Profile2Changed) {
      yield _mapParentProfileChangedToState(event);
    }
  }

  Profile2State _mapParentProfileChangedToState(Profile2Changed curr) {
    return Profile2Success(curr.parent);
  }

  void _mapParentProfile(Parent currParent) {
    add(Profile2Changed(currParent));
  }

  @override
  Future<void> close() {
    _profileBlocStream.cancel();
    _profile2Stream.cancel();
    return super.close();
  }
}
