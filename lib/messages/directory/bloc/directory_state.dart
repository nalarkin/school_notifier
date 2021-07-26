part of 'directory_bloc.dart';

enum DirectoryStatus { initial, success, failure }

class DirectoryState extends Equatable {
  const DirectoryState({required this.status, this.users = const <FirestoreUser>[]});

  final DirectoryStatus status;
  final List<FirestoreUser> users;

  @override
  List<Object> get props => [users];


}
