import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

class Teacher extends Equatable {
  const Teacher({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.joinDate,
    this.students,
    this.classes,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? joinDate;
  final Map<String, dynamic>? classes;
  final Map<String, dynamic>? students;

  Teacher copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      String? joinDate,
      Map<String, dynamic>? classes,
      Map<String, dynamic>? students}) {
    return Teacher(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      students: students ?? this.students,
      classes: classes ?? this.classes,
    );
  }

  @override
  List<Object?> get props =>
      [id, students, email, firstName, lastName, joinDate, classes, students];

  @override
  String toString() {
    return 'Teacher { id: $id, name: $firstName $lastName, '
        'students: $students, email: $email, joinDate: $joinDate, '
        'classes: $classes, students: $students}';
  }

  TeacherEntity toEntity() {
    return TeacherEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? '',
      students: students ?? {'' : ''},
      classes: students ?? {'' : ''},
    );
  }

  static Teacher fromEntity(TeacherEntity entity) {
    return Teacher(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      joinDate: entity.joinDate,
      students: entity.students,
      classes: entity.classes,
    );
  }

  /// Empty user which represents an Teacher placeholder.
  static const empty = Teacher(id: '');

  /// Convenience getter
  bool get isEmpty => this == Teacher.empty;

  /// Convenience getter
  bool get isNotEmpty => this != Teacher.empty;
}
