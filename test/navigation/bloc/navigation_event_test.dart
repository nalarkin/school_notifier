// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_repository/key_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';
import 'package:school_notifier/navigation/navigation.dart';


class MockUser extends Mock implements User {}

class MockFire extends Mock implements FirestoreUser {}
class MockKey extends Mock implements FirestoreKey {}


void main() {
  group('NavigationEvent', () {
    group('NavigationNewParent', () {
      // final parent = MockParent();
      final key = MockKey();
      final parent = MockFire();

      test('supports value comparisons', () {
        expect(
          NavigationNewParent(key: key, user: parent),
          NavigationNewParent(key: key, user: parent),
        );
      });
    });
    group('NavigationParentSignedIn', () {
      final parent = MockFire();
      test('supports value comparisons', () {
        expect(
          NavigationParentSignedIn(parent),
          NavigationParentSignedIn(parent),
        );
      });
    });

    group('NavigationTeacherSignedIn', () {
      final teacher = MockFire();
      test('supports value comparisons', () {
        expect(
          NavigationTeacherSignedIn(teacher),
          NavigationTeacherSignedIn(teacher),
        );
      });
    });
    group('NavigationStarted', () {
      test('supports value comparisons', () {
        final teacher = MockFire();
        expect(
          NavigationStarted(teacher),
          NavigationStarted(teacher),
        );
      });
    });
    group('NavigationLogoutRequested', () {
      test('supports value comparisons', () {
        final teacher = MockFire();
        expect(
          NavigationLogoutRequested(user: teacher),
          NavigationLogoutRequested(user: teacher),
        );
      });
    });
  });
}
