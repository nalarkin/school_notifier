import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/calendar/view/calendar_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/login/login.dart';
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
    FirestoreUser currUser = context.watch<ProfileBloc>().state.user;
    return Scaffold(
      drawer: customDrawer(context),
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
              child: const Text('Conversations Page'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProfilePage.routeName),
              child: const Text('Profile Page'),
            ),
            // MaterialButton(
            //   onPressed: () =>
            //       Navigator.pushNamed(context, EventPage.routeName),
            //   child: const Text('Event Page'),
            // ),
            // MaterialButton(
            //   onPressed: () => Navigator.pushNamed(context, KeyPage.routeName),
            //   child: const Text('Key Page'),
            // ),
            MaterialButton(
              onPressed: () {
                FirestoreEvent event = FirestoreEvent(
                    eventUID: 'nnieorsnaoientiroeantf983098',
                    title: '5 seconds',
                    posterID: 'posterID',
                    eventStartTime: DateTime.now().add(Duration(seconds: 5)),
                    eventEndTime: DateTime.now().add(Duration(seconds: 10)),
                    eventSubscriptionID: 'eventSubscriptionID');
                context
                    .read<EventRepository>()
                    .scheduleSingleNotification(event);
              },
              child: const Text('Schedule 1 notification'),
            ),
            MaterialButton(
              onPressed: () {
                FirestoreEvent event = FirestoreEvent(
                    eventUID: 'nnieorsnaoientiro92ntf983098',
                    title: '3 seconds',
                    description: '3 seconds description',
                    posterID: 'posterID',
                    eventStartTime: DateTime.now().add(Duration(seconds: 3)),
                    eventEndTime: DateTime.now().add(Duration(seconds: 10)),
                    eventSubscriptionID: 'eventSubscriptionID');
                FirestoreEvent event2 = FirestoreEvent(
                    eventUID: 'nnieo323434iroeantf983098',
                    title: '5 seconds',
                    description: '5 seconds description',
                    posterID: 'posterID',
                    eventStartTime: DateTime.now().add(Duration(seconds: 5)),
                    eventEndTime: DateTime.now().add(Duration(seconds: 10)),
                    eventSubscriptionID: 'eventSubscriptionID');
                FirestoreEvent event3 = FirestoreEvent(
                    eventUID: 'nnieor444444iroeantf983098',
                    title: '8 seconds',
                    description: '8 seconds description',
                    posterID: 'posterID',
                    eventStartTime: DateTime.now().add(Duration(seconds: 8)),
                    eventEndTime: DateTime.now().add(Duration(seconds: 10)),
                    eventSubscriptionID: 'eventSubscriptionID');
                context
                    .read<EventRepository>()
                    .scheduleMultipleNotifications([event, event2, event3]);
              },
              child: const Text('Schedule 3 notifications'),
            ),
            MaterialButton(
              onPressed: () async {
                final count = await context
                    .read<EventRepository>()
                    .countScheduledNotifications();
                print('$count notifications scheduled.');
              },
              child: const Text('Print Notification Count to Console'),
            ),
            MaterialButton(
              onPressed: () => context
                  .read<EventRepository>()
                  .deleteAllScheduledNotifications(),
              child: const Text('Clear all notifications'),
            ),
            MaterialButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SubscriptionPage.routeName),
              child: const Text('Subscription Page'),
            ),

            // debugButton(),
            if (currUser.role == UserRole.teacher ||
                currUser.role == UserRole.admin)
              MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CalendarPage.routeName),
                child: const Text('Calendar Page'),
              ),
          ],
        ),
      ),
    );
  }
}
