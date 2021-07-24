part of 'directory_bloc.dart';

abstract class DirectoryEvent extends Equatable {
  const DirectoryEvent();

  @override
  List<Object> get props => [];
}

class DirectoryStarted extends DirectoryEvent {}

class DirectorySentText extends DirectoryEvent {
  const DirectorySentText(this.content) : super();
  final String content;

  @override
  List<Object> get props => [content];
}

class DirectoryLoaded extends DirectoryEvent {
  const DirectoryLoaded(this.users) : super();
  final List<FirestoreUser> users;

  @override
  List<Object> get props => [users];
}
