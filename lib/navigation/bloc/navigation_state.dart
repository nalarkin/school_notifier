part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState({this.parent, this.teacher, this.user});

  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  
  @override
  List<Object> get props => [];
}


class NavigationTeacherSignInSuccess extends NavigationState {
  NavigationTeacherSignInSuccess({required teacher, parent, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class NavigationParentSignInSuccess extends NavigationState {
  NavigationParentSignInSuccess({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}
class NavigationNewParentSetup extends NavigationState {
  NavigationNewParentSetup({required parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}

class NavigationInitial extends NavigationState {
  NavigationInitial({parent, teacher, user})
      : super(teacher: teacher, parent: parent, user: user);
}


// AuthParentSignInSuccess

// AuthTeacherSignInSuccess

// AuthSignInFailure

// AuthInProgress

