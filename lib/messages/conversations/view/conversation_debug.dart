import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:users_repository/users_repository.dart';

class ConversationDebug extends StatelessWidget {
  const ConversationDebug({Key? key}) : super(key: key);
  static const String routeName = '/convo_debug';
  static Page page() => const MaterialPage<void>(child: ConversationDebug());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              key: const Key('homePage_logout_iconButton'),
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
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 4.0),
            const SizedBox(height: 4.0),
            const _AddMessage(),
            const SizedBox(height: 4.0),
            const _UpdateLastMessage(),
            const SizedBox(height: 4.0),
            const _SendMessage(),
            const SizedBox(height: 4.0),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ParentProfilePage.routeName),
              child: const Text('Profile Page'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, EventPage.routeName),
              child: const Text('Event Page'),
            ),
            // debugButton(),
          ],
        ),
      ),
    );
  }
}

class _AddMessage extends StatelessWidget {
  const _AddMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final idTo = 'AtQtsdVkaxR7v3czZN7sn6kTQuD3';
          final idFrom = 'UIk17Rc1EeQsJxn3DWh3EkuVZfp1';
          final convoID = Message.getConvoID(idTo, idFrom);
          context.read<MessageRepository>().addNewMessage(Message(
              id: '',
              conversationId: convoID,
              content: 'message content',
              idFrom: idFrom,
              idTo: idTo,
              mediaUrl: 'mediaUrl',
              timestamp: DateTime.now()));
        },
        child: Text('add message'));
  }
}

class _UpdateLastMessage extends StatelessWidget {
  const _UpdateLastMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final idTo = 'AtQtsdVkaxR7v3czZN7sn6kTQuD3';
          final idFrom = 'UIk17Rc1EeQsJxn3DWh3EkuVZfp1';
          final convoID = Message.getConvoID(idTo, idFrom);
          context.read<MessageRepository>().updateLastMessage(Message(
              id: '',
              conversationId: convoID,
              content: 'message content',
              idFrom: idFrom,
              idTo: idTo,
              mediaUrl: 'mediaUrl',
              timestamp: DateTime.now()));
        },
        child: Text('_UpdateLastMessage'));
  }
}

class _SendMessage extends StatelessWidget {
  const _SendMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final idTo = 'AtQtsdVkaxR7v3czZN7sn6kTQuD3';
          final idFrom = 'UIk17Rc1EeQsJxn3DWh3EkuVZfp1';
          final convoID = Message.getConvoID(idTo, idFrom);
          context.read<MessageRepository>().sendMessage(Message(
              id: '',
              conversationId: convoID,
              content: 'message content 2',
              idFrom: idFrom,
              idTo: idTo,
              mediaUrl: 'mediaUrl',
              timestamp: DateTime.now()));
        },
        child: Text('_SendMessage'));
  }
}
