part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  newTeacher,
  teacher,
  parent,
  newParent,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.parent = Parent.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  const AppState.newParent(Parent parent)
      : this._(status: AppStatus.newParent, parent: parent);
  const AppState.parent(Parent parent)
      : this._(status: AppStatus.parent, parent: parent);
  // const AppState.newTeacher(Teacher teacher) : this._(status: AppStatus.newTeacher);

  final AppStatus status;
  final User user;
  final Parent parent;
  // final Teacher teacher;

  Parent get getParent => parent;

  @override
  List<Object> get props => [status, user, parent];
}
