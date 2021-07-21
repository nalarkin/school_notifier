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
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    // NavigationStatus status = context.watch<NavigationBloc>().state.status;
    // String uid = '';
    // switch (status) {
    //   case NavigationStatus.parent:
    //     uid = context.read<NavigationBloc>().state.parent!.id;
    //     break;
    //   case NavigationStatus.teacher:
    //     uid = context.read<NavigationBloc>().state.teacher!.id;
    //     break;
    //   case NavigationStatus.student:
    //     uid = context.read<NavigationBloc>().state.teacher!.id;
    //     break;
    //   default:
    //     throw Exception('User was not a parent, teacher, or student.');
    // }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
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
          create: (_) =>
              ConversationBloc(context.read<MessageRepository>(),
              context.read<FirestoreParentsRepository>(),
              context.read<AuthenticationRepository>().currentUser.id),
          child: ConversationBuilder(),
        ));
  }
}
