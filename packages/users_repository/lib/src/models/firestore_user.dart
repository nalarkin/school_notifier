import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// import '../../users_repository.dart';
import 'package:users_repository/users_repository.dart';

class FirestoreUser extends Equatable {
  const FirestoreUser({
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

  FirestoreUser copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      Timestamp? joinDate,
      String? username}) {
    return FirestoreUser(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      joinDate: joinDate ?? this.joinDate,
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props =>
      [id, username, email, firstName, lastName, joinDate];

  @override
  String toString() {
    return '''FirestoreUser { id: $id, name: $firstName $lastName, 
            username: $username, email: $email, joinDate: $joinDate}''';
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      joinDate: joinDate,
      username: username,
    );
  }

  static FirestoreUser fromEntity(UserEntity entity) {
    return FirestoreUser(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      joinDate: entity.joinDate,
      username: entity.username,
    );
  }
}
