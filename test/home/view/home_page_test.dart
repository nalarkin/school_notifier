import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_notifier/authentication/authentication.dart';

class MockAppBloc extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class FakeAppEvent extends Fake implements AuthenticationEvent {}

class FakeAppState extends Fake implements AuthenticationState {}

class MockUser extends Mock implements User {}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');
  group('HomePage', () {
    late AuthenticationBloc appBloc;
    late User user;

    setUpAll(() {
      registerFallbackValue<AuthenticationEvent>(FakeAppEvent());
      registerFallbackValue<AuthenticationState>(FakeAppState());
    });

    setUp(() {
      appBloc = MockAppBloc();
      user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appBloc.state)
          .thenReturn(AuthenticationState.authenticated(user));
    });



    // group('renders', () {
    //   testWidgets('avatar widget', (tester) async {
    //     await tester.pumpWidget(
    //       BlocProvider.value(
    //         value: appBloc,
    //         child: const MaterialApp(home: HomePage()),
    //       ),
    //     );
    //     expect(find.byType(Avatar), findsOneWidget);
    //   });

    //   testWidgets('email address', (tester) async {
    //     await tester.pumpWidget(
    //       BlocProvider.value(
    //         value: appBloc,
    //         child: const MaterialApp(home: HomePage()),
    //       ),
    //     );
    //     expect(find.text('test@gmail.com'), findsOneWidget);
    //   });

    //   testWidgets('name', (tester) async {
    //     when(() => user.name).thenReturn('Joe');
    //     await tester.pumpWidget(
    //       BlocProvider.value(
    //         value: appBloc,
    //         child: const MaterialApp(home: HomePage()),
    //       ),
    //     );
    //     expect(find.text('Joe'), findsOneWidget);
    //   });
    // });
  });
}
