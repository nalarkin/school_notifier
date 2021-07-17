// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';
import 'package:school_notifier/navigation/navigation.dart';

class MockUser extends Mock implements User {}

class MockParent extends Mock implements Parent {}

class MockTeacher extends Mock implements Teacher {}

void main() {
  group('NavigationEvent', () {
    group('NavigationNewParent', () {
      // final parent = MockParent();
      final parent = Parent(id: '-');
      test('supports value comparisons', () {
        expect(
          NavigationNewParent(parent: parent),
          NavigationNewParent(parent: parent),
        );
      });
    });
    group('NavigationParentSignedIn', () {
      final parent = MockParent();
      test('supports value comparisons', () {
        expect(
          NavigationParentSignedIn(parent: parent),
          NavigationParentSignedIn(parent: parent),
        );
      });
    });

    group('NavigationTeacherSignedIn', () {
      final teacher = Teacher(id: '-');
      test('supports value comparisons', () {
        expect(
          NavigationTeacherSignedIn(teacher: teacher),
          NavigationTeacherSignedIn(teacher: teacher),
        );
      });
    });
    group('NavigationStarted', () {
      test('supports value comparisons', () {
        expect(
          NavigationStarted(),
          NavigationStarted(),
        );
      });
    });
    group('NavigationLogoutRequested', () {
      test('supports value comparisons', () {
        expect(
          NavigationLogoutRequested(),
          NavigationLogoutRequested(),
        );
      });
    });
  });
}
