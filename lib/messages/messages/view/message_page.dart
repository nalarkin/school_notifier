import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/view/conversation_builder.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/messages/messages/view/message_builder.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:users_repository/users_repository.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);
  static const String routeName = '/messages';
  static Page page() => const MaterialPage<void>(child: MessagePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final convo = ModalRoute.of(context)!.settings.arguments as Conversation;
    return Scaffold(
        appBar: AppBar(
          title: Text('${convo.lastMessage.id}'),
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
          create: (_) => MessageBloc(
            context.read<MessageRepository>(),
            convo,
            context.read<AuthenticationRepository>().currentUser.id,
          ),
          child: MessageBuilder(),
        ));
  }
}
