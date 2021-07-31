import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/view/conversation_builder.dart';
import 'package:school_notifier/messages/directory/view/view.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:users_repository/users_repository.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);
  static const String routeName = '/conversations';
  static Page page() => const MaterialPage<void>(child: ConversationPage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    FirestoreUser currUser = context.read<ProfileBloc>().state.user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          centerTitle: true,
          actions: <Widget>[
            if (currUser.role == UserRole.teacher ||
                currUser.role == UserRole.admin)
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, DirectoryPage.routeName),
                  icon: Icon(Icons.add))
          ],
        ),
        body: BlocProvider(
          create: (_) => ConversationBloc(
              context.read<MessageRepository>(),
              // context.read<FirestoreUserRepository>(),
              context.read<AuthenticationRepository>().currentUser.id),
          child: ConversationBuilder(),
        ));
  }
}
