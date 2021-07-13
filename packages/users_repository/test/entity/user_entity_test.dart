// ignore_for_file: prefer_const_constructors
// import 'user';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:users_repository/users_repository.dart';

void main() {
  group('UserEntity tests', () {
    const id = 'mock-id';
    const email = 'mock-email';
    const firstName = 'mock-firstName';
    const lastName = 'mock-lastName';
    var joinDate = Timestamp.fromMillisecondsSinceEpoch(1609459200000);
    const username = 'mock-username';
    var mockJson = {
      'id': id,
      'email':email,
      'firstName': firstName,
      'lastName': lastName,
      'joinDate': joinDate,
      'username': username,
    };

    test('UserEntity value equality', () {
      expect(
        UserEntity(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            joinDate: joinDate,
            username: username),
        UserEntity(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            joinDate: joinDate,
            username: username),
      );
    });

    test('UserEntity sucessfully created fromJson', () {
      var entity = UserEntity(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      

      expect(UserEntity.fromJson(mockJson), entity);
    });
    test('successfully created toDocument.', () {
      var entity = UserEntity(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      expect(entity.toDocument(), mockJson);
    });

    test('value remains the same fromJson toDocument.', () {
      expect(UserEntity.fromJson(mockJson).toDocument(), mockJson);
    });
  });
}
