import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'parent_profile_event.dart';
part 'parent_profile_state.dart';

class ParentProfileBloc extends Bloc<ParentProfileEvent, ParentProfileState> {
  ParentProfileBloc(
      {required FirestoreParentsRepository parentsRepository,
      required String parentId})
      : _parentsRepository = parentsRepository,
        _parentId = parentId,
        super(ParentProfileInitial()) {
    _profileStream =
        parentsRepository.liveProfileStream(parentId).listen(_mapParentProfile);
  }

  final FirestoreParentsRepository _parentsRepository;
  late StreamSubscription _profileStream;
  final String _parentId;

  @override
  Stream<ParentProfileState> mapEventToState(
    ParentProfileEvent event,
  ) async* {
    if (event is ParentProfileChanged) {}
  }

  ParentProfileState _mapParentProfileChangedToState(
      ParentProfileChanged curr) {
    return ParentProfileSuccess(curr.parent);
  }

  void _mapParentProfile(Parent currParent) {
    add(ParentProfileChanged(currParent));
  }
}
