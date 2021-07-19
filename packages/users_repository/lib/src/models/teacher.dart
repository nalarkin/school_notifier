import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

class Teacher extends Equatable {
  const Teacher({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.joinDate,
    this.photoID,
    this.classes,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? joinDate;
  final String? photoID;
  final Map<String, dynamic>? classes;

  Teacher copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      String? joinDate,
      String? photoID,
      Map<String, dynamic>? classes,
      }) {
    return Teacher(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      photoID: photoID ?? this.photoID,
      classes: classes ?? this.classes,
    );
  }

  @override
  List<Object?> get props =>
      [id, photoID, email, firstName, lastName, joinDate, classes];

  @override
  String toString() {
    return 'Teacher { id: $id, name: $firstName $lastName, '
        'students: $photoID, email: $email, joinDate: $joinDate, '
        'classes: $classes}';
  }

  TeacherEntity toEntity() {
    return TeacherEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? '',
      photoID: photoID ?? '',
      classes: classes ?? {'' : ''},
    );
  }

  static Teacher fromEntity(TeacherEntity entity) {
    return Teacher(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      joinDate: entity.joinDate,
      photoID: entity.photoID,
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
