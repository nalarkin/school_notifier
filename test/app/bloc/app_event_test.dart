// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/app/app.dart';

class MockUser extends Mock implements User {}

void main() {
  group('AppEvent', () {
    group('AppUserChanged', () {
      final user = MockUser();
      test('supports value comparisons', () {
        expect(
          AuthenticationUserChanged(user),
          AuthenticationUserChanged(user),
        );
      });
    });

    group('AppLogoutRequested', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLogoutRequested(),
          AuthenticationLogoutRequested(),
        );
      });
    });
  });
}
