part of 'profile_bloc.dart';

enum ProfileStatus {
  parent,
  newParent,
  teacher,
  newTeacher,
  student,
  newStudent,
  unknown,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState._(
      {required this.status,
      this.parent,
      this.teacher,
      this.user,
      this.student});

  final ProfileStatus status;
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;

  const ProfileState.parent(Parent parent)
      : this._(status: ProfileStatus.parent, parent: parent);

  const ProfileState.teacher(Teacher teacher)
      : this._(status: ProfileStatus.teacher, teacher: teacher);

  const ProfileState.student(Student student)
      : this._(status: ProfileStatus.student, student: student);
  const ProfileState.unknown() : this._(status: ProfileStatus.unknown);
  const ProfileState.newParent(User user)
      : this._(status: ProfileStatus.newParent, user: user);
  const ProfileState.newTeacher(User user)
      : this._(status: ProfileStatus.newTeacher, user: user);
  const ProfileState.newStudent(User user)
      : this._(status: ProfileStatus.newStudent, user: user);
  const ProfileState.failure()
      : this._(status: ProfileStatus.failure);

  @override
  List<Object?> get props => [status, user, parent, teacher];

  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
    Parent? parent,
    Teacher? teacher,
    Student? student,
  }) =>
      ProfileState._(
        status: status ?? this.status,
        user: user ?? this.user,
        parent: parent ?? this.parent,
        teacher: teacher ?? this.teacher,
        student: student ?? this.student,
      );
}


// class NavigationTeacherSignInSuccess extends NavigationState {
//   NavigationTeacherSignInSuccess({required teacher, parent, user})
//       : super(teacher: teacher, parent: parent, user: user);
// }

// class NavigationParentSignInSuccess extends NavigationState {
//   NavigationParentSignInSuccess({required parent, teacher, user})
//       : super(teacher: teacher, parent: parent, user: user);
// }
// class NavigationNewParentSetup extends NavigationState {
//   NavigationNewParentSetup({required parent, teacher, user})
//       : super(teacher: teacher, parent: parent, user: user);
// }

// class NavigationInitial extends NavigationState {
//   NavigationInitial({parent, teacher, user})
//       : super(teacher: teacher, parent: parent, user: user);
// }


// AuthParentSignInSuccess

// AuthTeacherSignInSuccess

// AuthSignInFailure

// AuthInProgress

// class AuthenticationState extends Equatable {
//   const AuthenticationState._({
//     required this.status,
//     this.user = User.empty,
//     this.parent = Parent.empty,
//   });

//   const AuthenticationState.authenticated(User user)
//       : this._(status: AuthenticationStatus.authenticated, user: user);

//   const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);
//   const AuthenticationState.newParent(Parent parent)
//       : this._(status: AuthenticationStatus.newParent, parent: parent);
//   const AuthenticationState.parent(Parent parent)
//       : this._(status: AuthenticationStatus.parent, parent: parent);
//   // const AppState.newTeacher(Teacher teacher) : this._(status: AppStatus.newTeacher);

//   final AuthenticationStatus status;
//   final User user;
//   final Parent parent;
//   // final Teacher teacher;

//   Parent get getParent => parent;

//   @override
//   List<Object> get props => [status, user, parent];
// }
