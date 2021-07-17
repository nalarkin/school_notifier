// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:users_repository/users_repository.dart';
import 'dart:async';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirestoreParentsRepository extends Mock
    implements FirestoreParentsRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockUser extends Mock implements User {}

class MockParent extends Mock implements Parent {}

class MockTeacher extends Mock implements Teacher {}

/// COULD USE MORE COMPREHENSIVE TESTS

void main() {
  setUpAll(() {
    registerFallbackValue(MockParent());
  });
  group('NavigationBloc', () {
    final user = MockUser();
    final parent = MockParent();
    final teacher = MockParent();
    late AuthenticationBloc authenticationBloc;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      when(() => authenticationBloc.stream).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    test('initial state is NavigationInitial', () {
      expect(
        NavigationBloc(authenticationBloc).state,
        NavigationInitial(),
      );
    });

    group('Parent Sign In', () {
      blocTest<NavigationBloc, NavigationState>(
        'emits NavigationParentSignInSuccess when AuthenticationBloc emits '
        'AuthenticationState.parent()',
        build: () {
          when(() => authenticationBloc.stream).thenAnswer(
              (_) => Stream.value(AuthenticationState.parent(parent)));

          return NavigationBloc(authenticationBloc);
        },
        seed: () => NavigationInitial(),
        expect: () => [NavigationParentSignInSuccess(parent: parent)],
      );
      blocTest<NavigationBloc, NavigationState>(
        'emits NavigationNewParentSetup when AuthenticationBloc emits '
        'AuthenticationState.newParent()',
        build: () {
          when(() => authenticationBloc.stream).thenAnswer(
              (_) => Stream.value(AuthenticationState.newParent(parent)));

          return NavigationBloc(authenticationBloc);
        },
        seed: () => NavigationInitial(),
        expect: () => [NavigationNewParentSetup(parent: parent)],
      );
    });
    blocTest<NavigationBloc, NavigationState>(
      'emits NavigationInitial when AuthenticationBloc emits '
      'AuthenticationState.unauthenticated()',
      build: () {
        when(() => authenticationBloc.stream).thenAnswer(
            (_) => Stream.value(AuthenticationState.unauthenticated()));

        return NavigationBloc(authenticationBloc);
      },
      seed: () => NavigationParentSignInSuccess(parent: parent),
      // wait: Duration(seconds: 2),
      expect: () => [NavigationInitial(parent: parent)],
    );
    // });
  });
}
