part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent({this.user, this.parent, this.teacher, this.student});
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;

  @override
  List<Object?> get props => [user, parent, teacher];
  // List<Object?> get props => [teacher];
}

class ProfileTeacherSignedIn extends ProfileEvent {
  ProfileTeacherSignedIn({required teacher, parent, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}

class ProfileParentSignedIn extends ProfileEvent {
  ProfileParentSignedIn({required parent, user})
      : super(parent: parent, user: user);
}
class ProfileFailed extends ProfileEvent {
  ProfileFailed()
      : super();
}

class ProfileNewParent extends ProfileEvent {
  ProfileNewParent({required parent, user})
      : super(parent: parent, user: user);
}
class ProfileNewParentCompleted extends ProfileEvent {
  ProfileNewParentCompleted({required parent, user})
      : super(parent: parent, user: user);
}
class ProfileUnknown extends ProfileEvent {
  ProfileUnknown()
      : super();
}

class ProfileStarted extends ProfileEvent {
  ProfileStarted({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user,student: student);
}
class ProfileLogoutRequested extends ProfileEvent {
  ProfileLogoutRequested({parent, teacher, user, student})
      : super(teacher: teacher, parent: parent, user: user, student: student);
}
