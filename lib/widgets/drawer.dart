import 'package:flutter/material.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/home/view/home_page.dart';
import 'package:school_notifier/messages/conversations/view/conversation_page.dart';
import 'package:school_notifier/profile/view/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/subscriptions/subscriptions.dart';
import 'package:school_notifier/subscriptions/view/subscriptions_page.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.headline6,
            // ?.copyWith(color: kOnPrimaryColor),
          ),
        ),
        ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            }),

        // ListTile(
        //   title: Text('Settings'),
        //   leading: Icon(
        //     Icons.settings,
        //     color: Colors.black,
        //   ),
        //   onTap: () {
        //     // Update the state of the app
        //     // ...
        //     // Then close the drawer
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, SettingsPage.routeName);
        //   },
        // ),
        ListTile(
            title: Text('Profile'),
            leading: Icon(
              Icons.face,
              color: Colors.black,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfilePage.routeName);
            }),

        ListTile(
            title: Text('Conversations'),
            leading: Icon(
              Icons.mail,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ConversationPage.routeName);
            }),
        ListTile(
            title: Text('Debug Links'),
            leading: Icon(
              Icons.bug_report,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, HomePage.routeName);
            }),
        ListTile(
            title: Text('Home'),
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, SubscriptionPage.routeName);
            }),
      ]));
}
