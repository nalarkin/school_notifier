import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

enum UserRole { student, teacher, parent, admin }

class FirestoreUser extends Equatable {
  const FirestoreUser({
    required this.id,
    this.email,
    this.avatarImage,
    this.firstName,
    this.lastName,
    this.joinDate,
    this.students,
    this.children,
    this.subscriptions,
    this.classes,
    this.role,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime? joinDate;
  final String? avatarImage;
  final Map<String, dynamic>? children;
  final Map<String, dynamic>? subscriptions;
  final Map<String, dynamic>? classes;
  final Map<String, dynamic>? students;
  final UserRole? role;

  FirestoreUser copyWith({
    String? id,
    String? avatarImage,
    String? email,
    String? firstName,
    String? lastName,
    DateTime? joinDate,
    Map<String, dynamic>? children,
    Map<String, dynamic>? classes,
    Map<String, dynamic>? students,
    UserRole? role,
  }) {
    return FirestoreUser(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarImage: avatarImage ?? this.avatarImage,
      joinDate: joinDate ?? this.joinDate,
      children: children ?? this.children,
      subscriptions: subscriptions ?? this.subscriptions,
      classes: classes ?? this.classes,
      students: students ?? this.students,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
        id,
        children,
        email,
        firstName,
        lastName,
        joinDate,
        classes,
        subscriptions,
        students,
        avatarImage
      ];

  @override
  String toString() {
    return '''FirestoreUser { id: $id, name: $firstName $lastName, 
            children: $children, email: $email, joinDate: $joinDate,
            subscriptions: $subscriptions, classes $classes, role: $role}''';
  }

  FirestoreUserEntity toEntity() {
    return FirestoreUserEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? DateTime.now(),
      avatarImage: avatarImage ?? '',
      children: children ?? {},
      subscriptions: subscriptions ?? {},
      classes: classes ?? {},
      students: students ?? {},
      role: userRoleToString(role) ?? '',
    );
  }

  static FirestoreUser fromEntity(FirestoreUserEntity entity) {
    return FirestoreUser(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      avatarImage: entity.avatarImage,
      joinDate: entity.joinDate,
      children: entity.children,
      subscriptions: entity.subscriptions,
      classes: entity.classes,
      students: entity.students,
      role: stringToUserRole(entity.role),
    );
  }

  /// Empty user which represents an parent placeholder.
  static const empty = FirestoreUser(id: '');

  /// Convenience getter
  bool get isEmpty => this == FirestoreUser.empty;

  /// Convenience getter
  bool get isNotEmpty => this != FirestoreUser.empty;
}

UserRole? stringToUserRole(String possibleRole) {
  for (final role in UserRole.values) {
    if (role.toString() == "UserRole.$possibleRole") {
      return role;
    }
  }
  return null;
}

String? userRoleToString(UserRole? role) {
  if (role == null) return null;
  return role.toString().split('.').last;
}
