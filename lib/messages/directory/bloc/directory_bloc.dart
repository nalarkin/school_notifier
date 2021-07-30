import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc(this._userRepository, this._user)
      : super(DirectoryState(status: DirectoryStatus.initial)) {
    _users = _userRepository.users().listen(_mapUserStreamToEvent);
    _filteredUsers = _mapFilteredUsers(_user);
  }
  late StreamSubscription _users;
  final FirestoreUserRepository _userRepository;
  late List<FirestoreUser> _filteredUsers;
  FirestoreUser _user;

  void _mapUserStreamToEvent(List<FirestoreUser> users) {
    add(DirectoryLoaded(users));
  }

  @override
  Stream<DirectoryState> mapEventToState(
    DirectoryEvent event,
  ) async* {
    if (event is DirectoryLoaded) {
      yield _mapDirectoryLoadedToState(event);
    } else if (event is DirectorySelectFiltered) {
      yield _mapFilteredToState(event);
      // DirectoryState(
      //     status: DirectoryStatus.filter, filteredUsers: _filteredUsers);
    } else if (event is DirectorySelectAllUsers) {
      yield state.copyWith(status: DirectoryStatus.success);

      //  DirectoryState(status: DirectoryStatus.success, users)
    }
  }

  @override
  Future<void> close() {
    _users.cancel();
    return super.close();
  }

  DirectoryState _mapFilteredToState(DirectorySelectFiltered event) {
    return state.copyWith(
        status: DirectoryStatus.filter, filteredUsers: _filteredUsers);
  }

  DirectoryState _mapDirectoryLoadedToState(DirectoryLoaded event) {
    if (state.status == DirectoryStatus.filter) {
      return DirectoryState(status: DirectoryStatus.filter, users: event.users);
    }
    return DirectoryState(status: DirectoryStatus.success, users: event.users);
  }

  List<FirestoreUser> _mapFilteredUsers(FirestoreUser _currUser) {
    final _students = _currUser.students;
    if (_students != null) {
      return [
        for (final user in _students.keys)
          FirestoreUser(
              id: user, firstName: _students[user], role: UserRole.student)
      ];
    }
    return [];
  }
}
