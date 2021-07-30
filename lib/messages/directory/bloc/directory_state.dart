part of 'directory_bloc.dart';

enum DirectoryStatus { initial, success, failure, filter }

class DirectoryState extends Equatable {
  const DirectoryState(
      {required this.status,
      this.users = const <FirestoreUser>[],
      this.filteredUsers = const <FirestoreUser>[]});

  final DirectoryStatus status;
  final List<FirestoreUser> users;
  final List<FirestoreUser> filteredUsers;

  @override
  List<Object> get props => [status, users, filteredUsers];

  DirectoryState copyWith({
    DirectoryStatus? status,
    List<FirestoreUser>? users,
    List<FirestoreUser>? filteredUsers,
  }) {
    return DirectoryState(
        status: status ?? this.status,
        users: users ?? this.users,
        filteredUsers: filteredUsers ?? this.filteredUsers);
  }
}
