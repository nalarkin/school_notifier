part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent({this.user, this.parent, this.teacher, this.student});
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;

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
class NavigationFailed extends NavigationEvent {
  NavigationFailed()
      : super();
}

class NavigationNewParent extends NavigationEvent {
  NavigationNewParent({required parent, user})
      : super(parent: parent, user: user);
}
class NavigationNewParentCompleted extends NavigationEvent {
  NavigationNewParentCompleted({required parent, user})
      : super(parent: parent, user: user);
}
class NavigationUnknown extends NavigationEvent {
  NavigationUnknown()
      : super();
}

class NavigationStarted extends NavigationEvent {
  NavigationStarted({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user,student: student);
}
class NavigationLogoutRequested extends NavigationEvent {
  NavigationLogoutRequested({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}
