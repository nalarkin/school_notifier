part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent({this.user, this.parent, this.teacher, this.student, this.key});
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;
  final FirestoreKey? key;

  @override
  List<Object?> get props => [user, parent, teacher];
  // List<Object?> get props => [teacher];
}

class NavigationTeacherSignedIn extends NavigationEvent {
  NavigationTeacherSignedIn({required teacher, parent, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}

class NavigationParentSignedIn extends NavigationEvent {
  NavigationParentSignedIn({required parent, user})
      : super(parent: parent, user: user);
}
class NavigationTokenAuthorized extends NavigationEvent {
  NavigationTokenAuthorized({required key})
      : super(key: key);
}



class NavigationFailed extends NavigationEvent {
  NavigationFailed() : super();
}

class NavigationNewParent extends NavigationEvent {
  NavigationNewParent({parent, required key, user})
      : super(parent: parent, user: user, key: key);
}
class NavigationNewParentInfoRequested extends NavigationEvent {
  NavigationNewParentInfoRequested({parent, required key, required user})
      : super(parent: parent, user: user, key: key);
}

class NavigationNewTeacher extends NavigationEvent {
  NavigationNewTeacher({required key, teacher, user})
      : super(teacher: teacher, user: user, key: key);
}

class NavigationNewParentCompleted extends NavigationEvent {
  NavigationNewParentCompleted({required parent, user})
      : super(parent: parent, user: user);
}

class NavigationUnknown extends NavigationEvent {
  NavigationUnknown() : super();
}

class NavigationStarted extends NavigationEvent {
  NavigationStarted({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}

class NavigationLogoutRequested extends NavigationEvent {
  NavigationLogoutRequested({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}
