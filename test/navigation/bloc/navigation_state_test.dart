// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_repository/key_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:users_repository/users_repository.dart';

class MockUser extends Mock implements User {}

class MockFire extends Mock implements FirestoreUser {}

class MockKey extends Mock implements FirestoreKey {}
// class MockUser extends Mock implements User {}

void main() {
  group('NavigationState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AuthenticationState.unauthenticated();
        expect(state.status, AuthenticationStatus.unauthenticated);
        expect(state.user, User.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final user = MockUser();
        final state = AuthenticationState.authenticated(user);
        expect(state.status, AuthenticationStatus.authenticated);
        expect(state.user, user);
      });
    });
    group('parent', () {
      test('has correct status', () {
        final parent = MockFire();
        final state = NavigationState.parent(parent);
        expect(state.status, NavigationStatus.parent);
        expect(state.user, parent);
      });
    });
    group('teacher', () {
      test('has correct status', () {
        final teacher = MockFire();
        final state = NavigationState.teacher(teacher);
        expect(state.status, NavigationStatus.teacher);
        expect(state.user, teacher);
      });
    });
    group('student', () {
      test('has correct status', () {
        final student = MockFire();
        final state = NavigationState.student(student);
        expect(state.status, NavigationStatus.student);
        expect(state.user, student);
      });
    });
    group('newParent', () {
      test('has correct status', () {
        final key = MockKey();
        final state = NavigationState.newParent(key);
        expect(state.status, NavigationStatus.newParent);
        expect(state.key, key);
      });
    });
  });
}
