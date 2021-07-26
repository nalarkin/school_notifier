part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  @visibleForTesting
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

// class AuthenticationNewParentJoined extends AuthenticationEvent {
//   @visibleForTesting
//   const AuthenticationNewParentJoined(this.user);

//   final User parent;

//   @override
//   List<Object> get props => [parent];
// }

// class AuthenticationParentAuthenticated extends AuthenticationEvent {
//   // @visibleForTesting
//   const AuthenticationParentAuthenticated(this.parent);

//   final Parent parent;

//   @override
//   List<Object> get props => [parent];
// }
