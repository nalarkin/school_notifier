import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

class Parent extends Equatable {
  const Parent({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.joinDate,
    this.children,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? joinDate;
  final List<dynamic>? children;

  Parent copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      String? joinDate,
      List<dynamic>? children}) {
    return Parent(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props =>
      [id, children, email, firstName, lastName, joinDate];

  @override
  String toString() {
    return '''Parent { id: $id, name: $firstName $lastName, 
            children: $children, email: $email, joinDate: $joinDate}''';
  }

  ParentEntity toEntity() {
    return ParentEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? '',
      children: children ?? [],
    );
  }

  static Parent fromEntity(ParentEntity entity) {
    return Parent(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      joinDate: entity.joinDate,
      children: entity.children,
    );
  }

  /// Empty user which represents an parent placeholder.
  static const empty = Parent(id: '');

  /// Convenience getter
  bool get isEmpty => this == Parent.empty;

  /// Convenience getter
  bool get isNotEmpty => this != Parent.empty;
}
