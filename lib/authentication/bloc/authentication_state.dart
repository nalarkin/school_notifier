part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  newTeacher,
  teacher,
  parent,
  newParent,
  logOutFailure,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user = User.empty,
    // this.parent = Parent.empty,
  });

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.logOutFailure() : this._(status: AuthenticationStatus.logOutFailure);
  // const AuthenticationState.newParent(Parent parent)
  //     : this._(status: AuthenticationStatus.newParent, parent: parent);
  // const AuthenticationState.parent(Parent parent)
  //     : this._(status: AuthenticationStatus.parent, parent: parent);
  // const AppState.newTeacher(Teacher teacher) : this._(status: AppStatus.newTeacher);

  final AuthenticationStatus status;
  final User user;
  // final Parent parent;
  // final Teacher teacher;

  // Parent get getParent => parent;

  @override
  List<Object> get props => [status, user];
}
