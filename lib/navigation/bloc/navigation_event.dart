part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent({this.user, this.parent, this.teacher});
  final User? user;
  final Parent? parent;
  final Teacher? teacher;

  @override
  List<Object?> get props => [user, parent, teacher];
}

class NavigationTeacherSignedIn extends NavigationEvent {
  NavigationTeacherSignedIn({required teacher, parent, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class NavigationParentSignedIn extends NavigationEvent {
  NavigationParentSignedIn({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class NavigationNewParent extends NavigationEvent {
  NavigationNewParent({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class NavigationStarted extends NavigationEvent {
  NavigationStarted({parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}
