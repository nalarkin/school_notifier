import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/theme.dart';
import 'package:users_repository/users_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FirestoreUsersRepository firestoreUsersRepository,
    // required PostsRepository postsRepository,
  })  : _authenticationRepository = authenticationRepository,
    _firestoreUsersRepository = firestoreUsersRepository,
        // _postsRepository = postsRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirestoreUsersRepository _firestoreUsersRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _authenticationRepository,
          ),
          RepositoryProvider.value(
            value: _firestoreUsersRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AppBloc(
                      authenticationRepository: _authenticationRepository,
                      firestoreUsersRepository :_firestoreUsersRepository,
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
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ));
    // routes: <String, WidgetBuilder>{
    //   PostsPage.routeName: (context) => PostsPage(),
    // });
  }
}
