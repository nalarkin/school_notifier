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
