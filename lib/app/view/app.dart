import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/auth/auth.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/profile_setup/view/view.dart';
import 'package:school_notifier/sign_up/view/view.dart';
import 'package:school_notifier/theme.dart';
import 'package:users_repository/users_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FirestoreParentsRepository firestoreParentsRepository,
    // required PostsRepository postsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _firestoreParentsRepository = firestoreParentsRepository,
        // _postsRepository = postsRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirestoreParentsRepository _firestoreParentsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _authenticationRepository,
          ),
          RepositoryProvider.value(
            value: _firestoreParentsRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AppBloc(
                      authenticationRepository: _authenticationRepository,
                      firestoreParentsRepository: _firestoreParentsRepository,
                    )),
            // BlocProvider(
            //     create: (_) => PostBloc(
            //           postsRepository: _postsRepository,
            //         )),
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: BlocProvider(
          create: (context) => AuthBloc(BlocProvider.of<AppBloc>(context)),
          child: AuthPage(),
        ),
        routes: <String, WidgetBuilder>{
          NewUserWelcomePage.routeName: (context) => NewUserWelcomePage(),
          ProfileSetupPage.routeName: (context) => ProfileSetupPage(),
          HomePage.routeName: (context) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
        });
  }
}
