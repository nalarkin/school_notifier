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
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextButton(
              child: Text('Add StudentKey'),
              onPressed: () => context
                  .read<KeyRepository>()
                  .generateNewStudentKeyFromStudentID(
                      'studentIDHERE.Studentkey'),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Text('Add ParentKey'),
              onPressed: () => context
                  .read<KeyRepository>()
                  .generateNewParentKeyFromStudentID('studentIDHERE.Parentkey'),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Text('Add TeacherKey'),
              onPressed: () => context
                  .read<KeyRepository>()
                  .generateNewTeacherKeyFromTeacherID('teacherIDHERE'),
            ),
            TextButton(
                child: Text('Print key 47wm9F9GnJ5L13K5ou68 if it exists'),
                onPressed: () async {
                  FirestoreKey? key = await context
                      .read<KeyRepository>()
                      .getKey('47wm9F9GnJ5L13K5ou68');
                  if (key != null) {
                    print(key);
                  }
                }),
          ],
        ));
  }
}
