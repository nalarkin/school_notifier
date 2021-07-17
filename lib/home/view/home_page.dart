import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar(photo: user.photo),
            const SizedBox(height: 4.0),
            // Text(user.email ?? '', style: textTheme.headline6),
            const SizedBox(height: 4.0),
            // Text(user.name ?? '', style: textTheme.headline5),
            const SizedBox(height: 4.0),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ParentProfilePage.routeName),
              child: const Text('Profile Page'),
            )
          ],
        ),
      ),
    );
  }
}
