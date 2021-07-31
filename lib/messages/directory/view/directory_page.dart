import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/view/conversation_builder.dart';
import 'package:school_notifier/messages/directory/view/directory_builder.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/messages/messages/view/message_builder.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:users_repository/users_repository.dart';

import '../directory.dart';

class DirectoryPage extends StatelessWidget {
  const DirectoryPage({Key? key}) : super(key: key);
  static const String routeName = '/directory_page';
  static Page page() => const MaterialPage<void>(child: DirectoryPage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    UserRole? role =
        context.watch<ProfileBloc>().state.user.role ?? UserRole.student;
    return Scaffold(
        // floatingActionButton:
        //     (role == UserRole.teacher || role == UserRole.admin)
        //         ? FloatingActionButton.extended(
        //             onPressed: () => context
        //                 .read<DirectoryBloc>()
        //                 .add(DirectorySelectFiltered()),
        //             label: Text('Your students.'))
        //         : null,
        appBar: AppBar(
          title: Text('Start a Conversation'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                key: const Key('conversation_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false);
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                })
          ],
        ),
        body: BlocProvider(
          create: (_) => DirectoryBloc(
            context.read<FirestoreUserRepository>(),
            context.read<ProfileBloc>().state.user,
          ),
          child: DirectoryBuilder(),
        ));
  }
}
