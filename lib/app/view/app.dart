import 'package:authentication_repository/authentication_repository.dart';
import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/profile/profile.dart';
// import 'package:school_notifier/profile_setup/view/view.dart';
import 'package:school_notifier/sign_up/view/view.dart';
import 'package:school_notifier/theme.dart';
import 'package:users_repository/users_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:key_repository/key_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required EventRepository eventRepository,
    // required PostsRepository postsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _eventRepository = eventRepository,
        // _postsRepository = postsRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final EventRepository _eventRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _authenticationRepository,
          ),
          RepositoryProvider(
            create: (_) => KeyRepository(),
          ),
          RepositoryProvider.value(
            value: _eventRepository,
          ),
          RepositoryProvider(
            create: (_) => MessageRepository(),
          ),
          RepositoryProvider(
            create: (_) => FirestoreUserRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AuthenticationBloc(
                      authenticationRepository: _authenticationRepository,
                    )),
            // BlocProvider(
            //     create: (_) => PostBloc(
            //           postsRepository: _postsRepository,
            //         )),
          ],
          child: const InitializeProviders1(),
        ));
  }
}

class InitializeProviders1 extends StatelessWidget {
  const InitializeProviders1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(
            BlocProvider.of<AuthenticationBloc>(context),
            context.read<FirestoreUserRepository>(),
            context.read<KeyRepository>(),
          ),
        ),
      ],
      child: InitializeProviders2(),
    );
  }
}

class InitializeProviders2 extends StatelessWidget {
  const InitializeProviders2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileBloc(
            context.read<FirestoreUserRepository>(),
            context.read<NavigationBloc>(),
          ),
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.dark,
      home: NavigationPage(),
      routes: allRoutes,
    );
    // return MaterialApp(
    //     theme: theme,
    //     darkTheme: darkTheme,
    //     // themeMode: ThemeMode.dark,
    //     home: BlocProvider(
    //       create: (context) =>
    //           NavigationBloc(BlocProvider.of<AuthenticationBloc>(context)),
    //       child: NavigationPage(),
    //     ),
    //     routes: allRoutes,

    // <String, WidgetBuilder>{
    //   NewUserWelcomePage.routeName: (context) => NewUserWelcomePage(),
    //   ProfileSetupPage.routeName: (context) => ProfileSetupPage(),
    //   HomePage.routeName: (context) => HomePage(),
    //   LoginPage.routeName: (context) => LoginPage(),
    //   SignUpPage.routeName: (context) => SignUpPage(),
    // }
    // );
  }
}
