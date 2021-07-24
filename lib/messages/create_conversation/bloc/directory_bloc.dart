import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  DirectoryBloc(this._userRepository, this._uid) : super(DirectoryState(status: DirectoryStatus.initial));
  FirestoreUserRepository _userRepository;
  String _uid;

  @override
  Stream<DirectoryState> mapEventToState(
    DirectoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
