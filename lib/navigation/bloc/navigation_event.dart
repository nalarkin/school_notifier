part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent({this.user = FirestoreUser.empty, this.key});
  final FirestoreUser user;
  final FirestoreKey? key;

  @override
  List<Object?> get props => [user];
  // List<Object?> get props => [teacher];
}

class NavigationTeacherSignedIn extends NavigationEvent {
  const NavigationTeacherSignedIn({required user}) : super(user: user);
}

class NavigationParentSignedIn extends NavigationEvent {
  const NavigationParentSignedIn({required user}) : super(user: user);
}
class NavigationStudentSignedIn extends NavigationEvent {
  const NavigationStudentSignedIn({required user}) : super(user: user);
}
class NavigationUserSignedIn extends NavigationEvent {
  const NavigationUserSignedIn({required user}) : super(user: user);
}

class NavigationTokenAuthorized extends NavigationEvent {
  const NavigationTokenAuthorized({required key}) : super(key: key);
}

class NavigationFailed extends NavigationEvent {
  const NavigationFailed(this.message) : super();
  final String message;
}

class NavigationNewParent extends NavigationEvent {
  const NavigationNewParent({required key, user}) : super(user: user, key: key);
}
// class NavigationNewParentInfoRequested extends NavigationEvent {
//   NavigationNewParentInfoRequested({required key, required user})
//       : super(user: user, key: key);
// }

class NavigationNewTeacher extends NavigationEvent {
  const NavigationNewTeacher({required key, user})
      : super(user: user, key: key);
}

class NavigationNewParentCompleted extends NavigationEvent {
  const NavigationNewParentCompleted({required user}) : super(user: user);
}

class NavigationUnknown extends NavigationEvent {
  const NavigationUnknown() : super();
}

class NavigationStarted extends NavigationEvent {
  const NavigationStarted({required user}) : super(user: user);
}

class NavigationLogoutRequested extends NavigationEvent {
  const NavigationLogoutRequested({user}) : super(user: user);
}
