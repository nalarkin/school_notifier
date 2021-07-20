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
    this.subscriptions,
    this.classes,
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? joinDate;
  final Map<String, dynamic>? children;
  final Map<String, dynamic>? subscriptions;
  final Map<String, dynamic>? classes;

  Parent copyWith(
      {String? email,
      String? firstName,
      String? id,
      String? lastName,
      String? joinDate,
      Map<String, dynamic>? children,
      Map<String, dynamic>? classes,
      }) {
    return Parent(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      children: children ?? this.children,
      subscriptions: subscriptions ?? this.subscriptions,
      classes: classes ?? this.classes,
    );
  }

  @override
  List<Object?> get props =>
      [id, children, email, firstName, lastName, joinDate, classes, subscriptions];

  @override
  String toString() {
    return '''Parent { id: $id, name: $firstName $lastName, 
            children: $children, email: $email, joinDate: $joinDate,
            subscriptions: $subscriptions, classes $classes}''';
  }

  ParentEntity toEntity() {
    return ParentEntity(
      id: id,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      joinDate: joinDate ?? '',
      children: children ?? {},
      subscriptions: subscriptions ?? {},
      classes: classes ?? {},
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
      subscriptions: entity.subscriptions,
      classes: entity.classes,
    );
  }

  /// Empty user which represents an parent placeholder.
  static const empty = Parent(id: '');

  /// Convenience getter
  bool get isEmpty => this == Parent.empty;

  /// Convenience getter
  bool get isNotEmpty => this != Parent.empty;
}
