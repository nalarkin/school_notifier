part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent({this.parent, this.teacher});

  Parent? parent;
  Teacher? 


  @override
  List<Object> get props => [];
}

class AuthTeacherSignedIn extends AuthEvent {}

class AuthParentSignedIn extends AuthEvent {}

class AuthStarted extends AuthEvent {}
