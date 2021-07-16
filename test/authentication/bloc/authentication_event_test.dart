// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:users_repository/users_repository.dart';

class MockUser extends Mock implements User {}
class MockParent extends Mock implements Parent {}

void main() {
  group('AuthenticationEvent', () {
    group('AuthenticationNewParentJoined', () {
      final parent = MockParent();
      test('supports value comparisons', () {
        expect(
          AuthenticationNewParentJoined(parent),
          AuthenticationNewParentJoined(parent),
        );
      });
    });
    group('AuthenticationParentAuthenticated', () {
      final parent = MockParent();
      test('supports value comparisons', () {
        expect(
          AuthenticationParentAuthenticated(parent),
          AuthenticationParentAuthenticated(parent),
        );
      });
    });

    group('AuthenticationLogoutRequested', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLogoutRequested(),
          AuthenticationLogoutRequested(),
        );
      });
    });
  });
}
