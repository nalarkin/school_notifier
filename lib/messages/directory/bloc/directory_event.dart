part of 'directory_bloc.dart';

abstract class DirectoryEvent extends Equatable {
  const DirectoryEvent();

  @override
  List<Object> get props => [];
}

class DirectoryStarted extends DirectoryEvent {}


class DirectoryLoaded extends DirectoryEvent {
  const DirectoryLoaded(this.users) : super();
  final List<FirestoreUser> users;

  @override
  List<Object> get props => [users];
}

class DirectorySelectFiltered extends DirectoryEvent {
  const DirectorySelectFiltered() : super();
  @override
  List<Object> get props => [];

}
class DirectorySelectAllUsers extends DirectoryEvent {
  const DirectorySelectAllUsers() : super();
  @override
  List<Object> get props => [];

}
