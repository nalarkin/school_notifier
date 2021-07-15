part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent({this.user, this.parent, this.teacher});
  final User? user;
  final Parent? parent;
  final Teacher? teacher;

  @override
  List<Object?> get props => [user, parent, teacher];
}

class AuthTeacherSignedIn extends AuthEvent {
  AuthTeacherSignedIn({required teacher, parent, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class AuthParentSignedIn extends AuthEvent {
  AuthParentSignedIn({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class AuthNewParent extends AuthEvent {
  AuthNewParent({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class AuthStarted extends AuthEvent {
  AuthStarted({parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}
