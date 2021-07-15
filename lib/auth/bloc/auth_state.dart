part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({this.parent, this.teacher, this.user});

  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  
  @override
  List<Object> get props => [];
}


class AuthTeacherSignInSuccess extends AuthState {
  AuthTeacherSignInSuccess({required teacher, parent, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class AuthParentSignInSuccess extends AuthState {
  AuthParentSignInSuccess({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}
class AuthNewParentSetup extends AuthState {
  AuthNewParentSetup({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class AuthInitial extends AuthState {
  AuthInitial({parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}


// AuthParentSignInSuccess

// AuthTeacherSignInSuccess

// AuthSignInFailure

// AuthInProgress

