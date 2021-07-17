import 'package:flutter/material.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyDebugPage extends StatelessWidget {
  static const String routeName = '/key_debug_page';
  const KeyDebugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: TextButton(
            child: Text('Add Key'),
            onPressed: () => context
                .read<KeyRepository>()
                .generateNewKeyFromStudentID('studentIDHERE'),
          ),
        ));
  }
}
