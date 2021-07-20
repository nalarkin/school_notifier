part of 'navigation_bloc.dart';

enum NavigationStatus {
  parent,
  newParent,
  teacher,
  newTeacher,
  student,
  newStudent,
  unknown,
  failure,
}

class NavigationState extends Equatable {
  const NavigationState._(
      {required this.status,
      this.parent,
      this.teacher,
      this.user,
      this.student});

  final NavigationStatus status;
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;

  const NavigationState.parent(Parent parent)
      : this._(status: NavigationStatus.parent, parent: parent);

  const NavigationState.teacher(Teacher teacher)
      : this._(status: NavigationStatus.teacher, teacher: teacher);

  const NavigationState.student(Student student)
      : this._(status: NavigationStatus.student, student: student);
  const NavigationState.unknown() : this._(status: NavigationStatus.unknown);
  // const NavigationState.newParent(User user)
  //     : this._(status: ProfileStatus.newParent, user: user);
  const NavigationState.newParent(Parent parent)
      : this._(status: NavigationStatus.newParent, parent: parent);
  const NavigationState.newTeacher(User user)
      : this._(status: NavigationStatus.newTeacher, user: user);
  const NavigationState.newStudent(User user)
      : this._(status: NavigationStatus.newStudent, user: user);
  const NavigationState.failure() : this._(status: NavigationStatus.failure);

  @override
  List<Object?> get props => [status, user, parent, teacher];

  NavigationState copyWith({
    NavigationStatus? status,
    User? user,
    Parent? parent,
    Teacher? teacher,
    Student? student,
  }) =>
      NavigationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        parent: parent ?? this.parent,
        teacher: teacher ?? this.teacher,
        student: student ?? this.student,
      );
}
