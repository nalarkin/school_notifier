part of 'navigation_bloc.dart';

enum NavigationStatus {
  parent,
  teacher,
  student,
  newParent,
  newTeacher,
  newStudent,
  admin,
  tokenAuthorized,
  unknown,
  failure,
}

class NavigationState extends Equatable {
  const NavigationState._(
      {required this.status,
      this.user = FirestoreUser.empty,
      this.key});

  final NavigationStatus status;
  final FirestoreUser user;
  final FirestoreKey? key;

  const NavigationState.parent(FirestoreUser user)
      : this._(status: NavigationStatus.parent, user: user);

  const NavigationState.teacher(FirestoreUser user)
      : this._(status: NavigationStatus.teacher, user: user);

  const NavigationState.student(FirestoreUser user)
      : this._(status: NavigationStatus.student, user: user);
  const NavigationState.unknown() : this._(status: NavigationStatus.unknown);
  // const NavigationState.newParent(User user)
  //     : this._(status: ProfileStatus.newParent, user: user);

  const NavigationState.newParent(FirestoreKey key)
      : this._(status: NavigationStatus.newParent, key: key);
  // const NavigationState.newParentAdditionalInfo(Parent parent)
  //     : this._(
  //           status: NavigationStatus.newParentAdditionalInfo, parent: parent);

  const NavigationState.newTeacher(FirestoreKey key)
      : this._(status: NavigationStatus.newTeacher, key: key);
  const NavigationState.newStudent(FirestoreKey key)
      : this._(status: NavigationStatus.newStudent, key: key);

  const NavigationState.tokenAuthorized(FirestoreKey key)
      : this._(status: NavigationStatus.tokenAuthorized, key: key);
  const NavigationState.failure() : this._(status: NavigationStatus.failure);

  @override
  List<Object?> get props => [status, user, key];

  NavigationState copyWith({
    NavigationStatus? status,
    FirestoreUser? user,
    FirestoreKey? key,
  }) =>
      NavigationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        key: key ?? this.key,
      );
}
