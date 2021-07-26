import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/firestore_user_debug/firestore_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/key_stuff/key_page.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/view/conversation_debug.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/subscriptions/subscriptions.dart';
import 'package:school_notifier/subscriptions/view/add_subscription_page.dart';
import 'package:school_notifier/widgets/drawer.dart';
import 'package:users_repository/users_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      // drawer: customDrawer(context),
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
            // Avatar(photo: user.photo),
            const SizedBox(height: 4.0),
            // Text(user.email ?? '', style: textTheme.headline6),
            const SizedBox(height: 4.0),
            // Text(user.name ?? '', style: textTheme.headline5),
            const SizedBox(height: 4.0),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ConversationPage.routeName),
              child: const Text('Convo Page'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProfilePage.routeName),
              child: const Text('Universal Profile Page'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, EventPage.routeName),
              child: const Text('Event Page'),
            ),
            MaterialButton(
              onPressed: () => Navigator.pushNamed(context, KeyPage.routeName),
              child: const Text('Key Page'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddSubscriptionPage.routeName),
              child: const Text('Add Subscription'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SubscriptionPage.routeName),
              child: const Text('Subscription Page'),
            ),

            // debugButton(),
          ],
        ),
      ),
    );
  }
}
