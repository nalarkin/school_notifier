// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ParentEntity extends Equatable {
  const ParentEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.children,
    required this.subscriptions,
    required this.classes,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String joinDate;
  final Map<String, dynamic> children;
  final Map<String, dynamic> subscriptions;
  final Map<String, dynamic> classes;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'children': children,
      'subscriptions': subscriptions,
      'classes': classes,
    };
  }

  @override
  List<Object> get props =>
      [id, children, email, firstName, lastName, joinDate, classes, subscriptions];

  @override
  String toString() {
    return '''ParentEntity { id: $id, name: $firstName $lastName, 
            children: $children, email: $email, joinDate: $joinDate, 
            classes: $classes}''';
  }

  static ParentEntity fromJson(Map<String, Object> json) {
    return ParentEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      joinDate: json['joinDate'].toString(),
      children: json['children'] as Map<String, dynamic>,
      subscriptions: json['subscriptions'] as Map<String, dynamic>,
      classes: json['classes'] as Map<String, dynamic>,
    );
  }

  static ParentEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return ParentEntity(
      id: data['id'] as String,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      joinDate: data['joinDate'] as String,
      children: data['children'] as Map<String, dynamic>,
      subscriptions: data['subscriptions'] as Map<String, dynamic>,
      classes: data['classes'] as Map<String, dynamic>,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'children': children,
      'subscriptions': subscriptions,
      'classes': classes,
    };
  }
}
