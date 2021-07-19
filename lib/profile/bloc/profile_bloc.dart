import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
      {required FirestoreParentsRepository parentsRepository,
      required Firestore
      required String parentId})
      : _parentsRepository = parentsRepository,
        _parentId = parentId,
        super(ProfileInitial()) {
    _profileStream =
        parentsRepository.liveProfileStream(parentId).listen(_mapParentProfile);
  }

  final FirestoreParentsRepository _parentsRepository;
  late StreamSubscription _profileStream;
  final String _parentId;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileChanged) {
      yield _mapProfileChangedToState(event);
    }
  }

  ProfileState _mapProfileChangedToState(
      ProfileChanged curr) {
        
    return ProfileSuccess(curr.parent);
  }

  void _mapParentProfile(Parent currParent) {
    add(ParentProfileChanged(currParent));
  }


 
  @override
  Future<void> close() {
    _profileStream.cancel();
    return super.close();
  }
}
