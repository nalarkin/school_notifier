// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';

class MockUser extends Mock implements User {}

class MockParent extends Mock implements FirestoreUser {}
// class MockUser extends Mock implements User {}

void main() {
  group('AppState', () {
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
  });
}
