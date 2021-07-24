import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:users_repository/users_repository.dart';

class FirestoreUserEntity extends Equatable {
  const FirestoreUserEntity({
    required this.id,
    required this.email,
    required this.avatarImage,
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.students,
    required this.children,
    required this.subscriptions,
    required this.classes,
    required this.parents,
    required this.role,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime joinDate;
  final String avatarImage;
  final Map<String, dynamic> children;
  final Map<String, dynamic> subscriptions;
  final Map<String, dynamic> classes;
  final Map<String, dynamic> parents;
  final Map<String, dynamic> students;
  final String role;

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
        parents,
        avatarImage,
        role,
      ];

  @override
  String toString() {
    return '''FirestoreUserEntity { id: $id, name: $firstName $lastName, 
            children: $children, email: $email, joinDate: $joinDate,
            subscriptions: $subscriptions, classes $classes}''';
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email ,
      'firstName': firstName ,
      'lastName': lastName ,
      'joinDate': joinDate ,
      'avatarImage': avatarImage,
      'children': children ,
      'subscriptions': subscriptions ,
      'classes': classes ,
      'students': students ,
      'parents': parents ,
      'role': role ,
      
    };
  }

  static FirestoreUserEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return FirestoreUserEntity(
      id: data['id'] as String,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      avatarImage: data['avatarImage'] as String,
      joinDate: (data['joinDate'] as Timestamp).toDate(),
      children: data['children'] as Map<String, dynamic>,
      subscriptions: data['subscriptions'] as Map<String, dynamic>,
      classes: data['classes'] as Map<String, dynamic>,
      students: data['students'] as Map<String, dynamic>,
      parents: data['parents'] as Map<String, dynamic>,
      role: data['role'] as String,
    );
  }
}
