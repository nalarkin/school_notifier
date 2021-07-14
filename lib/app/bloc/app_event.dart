part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
class AppNewParentJoined extends AppEvent {
  @visibleForTesting
  const AppNewParentJoined(this.parent);

  final Parent parent;

  @override
  List<Object> get props => [parent];
}
class AppParentAuthenticated extends AppEvent {
  // @visibleForTesting
  const AppParentAuthenticated(this.parent);

  final Parent parent;

  @override
  List<Object> get props => [parent];
}
