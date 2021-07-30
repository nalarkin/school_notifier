import 'package:authentication_repository/authentication_repository.dart';
import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/calendar/view/calendar_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/view/conversation_builder.dart';
import 'package:school_notifier/messages/directory/view/view.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/subscriptions/view/subscriptions_builder.dart';
import 'package:school_notifier/widgets/drawer.dart';
import 'package:users_repository/users_repository.dart';
import 'package:school_notifier/subscriptions/subscriptions.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);
  static const String routeName = '/sub_page';
  static Page page() => const MaterialPage<void>(child: SubscriptionPage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    UserRole role =
        context.watch<ProfileBloc>().state.user.role ?? UserRole.student;
    return Scaffold(
        drawer: customDrawer(context),
        floatingActionButton: role == UserRole.teacher || role == UserRole.admin
            ? FloatingActionButton.extended(
                label: Text("Calendar View"),
                icon: Icon(Icons.calendar_today),
                onPressed: () =>
                    Navigator.pushNamed(context, CalendarPage.routeName),
              )
            : null,
        appBar: AppBar(
          title: const Text('Upcoming Events'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: Icon(Icons.exit_to_app),
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
          create: (_) => SubscriptionBloc(
            context.read<EventRepository>(),
            context.read<ProfileBloc>(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubscriptionBuilder(),
          ),
        ));
  }
}
