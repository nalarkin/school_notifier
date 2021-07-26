import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc(this._userRepository, this._uid)
      : super(DirectoryState(status: DirectoryStatus.initial)) {
    _users = _userRepository.users().listen(_mapUserStreamToEvent);
  }
  late StreamSubscription _users;
  final FirestoreUserRepository _userRepository;
  String _uid;

  void _mapUserStreamToEvent(List<FirestoreUser> users) {
    add(DirectoryLoaded(users));
  }

  @override
  Stream<DirectoryState> mapEventToState(
    DirectoryEvent event,
  ) async* {
    if (event is DirectoryLoaded) {
      yield DirectoryState(status: DirectoryStatus.success, users: event.users);
    }
  }
}
