// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.username,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final Timestamp joinDate;
  final String username;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'username': username,
    };
  }

  @override
  List<Object> get props =>
      [id, username, email, firstName, lastName, joinDate];

  @override
  String toString() {
    return '''UserEntity { id: $id, name: $firstName $lastName, 
            username: $username, email: $email, joinDate: $joinDate}''';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      joinDate: json['joinDate'] as Timestamp,
      username: json['username'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return UserEntity(
      id: data['id'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      joinDate: data['joinDate'],
      username: data['username'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'username': username,
    };
  }
}
