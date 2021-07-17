// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TeacherEntity extends Equatable {
  const TeacherEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.classes,
    required this.students,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String joinDate;
  final Map<String, dynamic> classes;
  final Map<String, dynamic> students;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'classes': classes,
      'students': students,
    };
  }

  @override
  List<Object> get props => [id, classes, email, firstName, lastName, joinDate, students];

  @override
  String toString() {
    return '''TeacherEntity { id: $id, name: $firstName $lastName, 
            classes: $classes, email: $email, joinDate: $joinDate}''';
  }

  static TeacherEntity fromJson(Map<String, Object> json) {
    return TeacherEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      joinDate: json['joinDate'].toString(),
      classes: json['classes'] as Map<String, dynamic>,
      students: json['students'] as Map<String, dynamic>,
    );
  }

  static TeacherEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return TeacherEntity(
      id: data['id'] as String,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      joinDate: data['joinDate'].toString(),
      classes: data['classes'] as Map<String, dynamic>,
      students: data['students'] as Map<String, dynamic>,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'classes': classes,
      'students': students,
    };
  }
}
