part of 'navigation_bloc.dart';

enum NavigationStatus {
  parent,
  newParent,
  newParentAdditionalInfo,
  teacher,
  newTeacher,
  student,
  newStudent,
  tokenAuthorized,
  unknown,
  failure,
}

class NavigationState extends Equatable {
  const NavigationState._(
      {required this.status,
      this.parent,
      this.teacher,
      this.user,
      this.student,
      this.key});

  final NavigationStatus status;
  final User? user;
  final Parent? parent;
  final Teacher? teacher;
  final Student? student;
  final FirestoreKey? key;


  const NavigationState.parent(Parent parent)
      : this._(status: NavigationStatus.parent, parent: parent);

  const NavigationState.teacher(Teacher teacher)
      : this._(status: NavigationStatus.teacher, teacher: teacher);

  const NavigationState.student(Student student)
      : this._(status: NavigationStatus.student, student: student);
  const NavigationState.unknown() : this._(status: NavigationStatus.unknown);
  // const NavigationState.newParent(User user)
  //     : this._(status: ProfileStatus.newParent, user: user);


  const NavigationState.newParent(FirestoreKey key)
      : this._(status: NavigationStatus.newParent, key: key);
  const NavigationState.newParentAdditionalInfo(Parent parent)
      : this._(status: NavigationStatus.newParentAdditionalInfo, parent: parent);
      
  const NavigationState.newTeacher(FirestoreKey key)
      : this._(status: NavigationStatus.newTeacher, key: key);
  const NavigationState.newStudent(FirestoreKey key)
      : this._(status: NavigationStatus.newStudent, key: key);



  const NavigationState.tokenAuthorized(FirestoreKey key)
      : this._(status: NavigationStatus.tokenAuthorized, key: key);
  const NavigationState.failure() : this._(status: NavigationStatus.failure);

  @override
  List<Object?> get props => [status, user, parent, teacher, key];

  NavigationState copyWith({
    NavigationStatus? status,
    User? user,
    Parent? parent,
    Teacher? teacher,
    Student? student,
    FirestoreKey? key,
  }) =>
      NavigationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        parent: parent ?? this.parent,
        teacher: teacher ?? this.teacher,
        student: student ?? this.student,
        key: key ?? this.key,
      );
}
