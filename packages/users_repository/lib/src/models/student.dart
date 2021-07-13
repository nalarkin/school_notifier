import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

class Student extends Equatable {
  const Student({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.joinDate,
    this.parents,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? joinDate;
  final List<String>? parents;

  Student copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      String? joinDate,
      List<String>? parents}) {
    return Student(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      parents: parents ?? this.parents,
    );
  }

  @override
  List<Object?> get props =>
      [id, parents, email, firstName, lastName, joinDate];

  @override
  String toString() {
    return '''Student { id: $id, name: $firstName $lastName, 
            parents: $parents, email: $email, joinDate: $joinDate}''';
  }

  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? '',
      parents: parents ?? [],
    );
  }

  static Student fromEntity(StudentEntity entity) {
    return Student(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      joinDate: entity.joinDate,
      parents: entity.parents,
    );
  }

  /// Empty user which represents an student placeholder.
  static const empty = Student(id: '');

  /// Convenience getter
  bool get isEmpty => this == Student.empty;

  /// Convenience getter
  bool get isNotEmpty => this != Student.empty;
}
