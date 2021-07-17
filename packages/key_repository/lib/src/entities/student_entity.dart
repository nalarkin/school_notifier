// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  const StudentEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.parents,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String joinDate;
  final List<String> parents;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'parents': parents,
    };
  }

  @override
  List<Object> get props => [id, parents, email, firstName, lastName, joinDate];

  @override
  String toString() {
    return '''StudentEntity { id: $id, name: $firstName $lastName, 
            parents: $parents, email: $email, joinDate: $joinDate}''';
  }

  static StudentEntity fromJson(Map<String, Object> json) {
    return StudentEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      joinDate: json['joinDate'].toString(),
      parents: json['parents'] as List<String>,
    );
  }

  static StudentEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return StudentEntity(
      id: data['id'] as String,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      joinDate: data['joinDate'] as String,
      parents: data['parents'] as List<String>,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'parents': parents,
    };
  }
}
