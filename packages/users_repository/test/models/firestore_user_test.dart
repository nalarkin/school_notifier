// ignore_for_file: prefer_const_constructors
// import 'user';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:users_repository/users_repository.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';
    const firstName = 'mock-firstName';
    const lastName = 'mock-lastName';
    var joinDate = Timestamp.fromMillisecondsSinceEpoch(1609459200000);
    const username = 'mock-username';

    test('FirestoreUser value equality', () {
      expect(
        FirestoreUser(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            joinDate: joinDate,
            username: username),
        FirestoreUser(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            joinDate: joinDate,
            username: username),
      );
    });

    test('FirestoreUser copyWith copies the correct values', () {
      var beforeChange = FirestoreUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      var expectedChange = FirestoreUser(
          id: id,
          email: 'updated-email',
          firstName: 'updated-firstName',
          lastName: 'updated-lastName',
          joinDate: Timestamp.fromMillisecondsSinceEpoch(1209459200000),
          username: 'updated-username');

      expect(
          beforeChange.copyWith(
              username: 'updated-username',
              email: 'updated-email',
              firstName: 'updated-firstName',
              lastName: 'updated-lastName',
              joinDate: Timestamp.fromMillisecondsSinceEpoch(1209459200000)),
          expectedChange);
    });
    test('FirestoreUser copyWith maintains all values not provided.', () {
      var beforeChange = FirestoreUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      expect(beforeChange.copyWith(), beforeChange);
    });

    test('FirestoreUser sucessfully converts to UserEntity', () {
      final user = FirestoreUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      final entity = UserEntity(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);

      expect(user.toEntity(), entity);
    });

    test('FirestoreUser is created when given an UserEntity.', () {
      final user = FirestoreUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);
      final entity = UserEntity(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          joinDate: joinDate,
          username: username);

      expect(FirestoreUser.fromEntity(entity), user);
    });
  });
}
