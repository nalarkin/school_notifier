import 'package:flutter/widgets.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/key_stuff/key_page.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/messages/conversations/conversations.dart';
import 'package:school_notifier/messages/conversations/view/conversation_debug.dart';
import 'package:school_notifier/messages/directory/view/directory_page.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
// import 'package:school_notifier/profile_setup/view/new_user_setup_page.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/profile/view/profile_page.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:school_notifier/subscriptions/view/add_subscription_page.dart';
import 'package:school_notifier/subscriptions/view/subscriptions_page.dart';
import 'package:school_notifier/token/token.dart';

Map<String, WidgetBuilder> allRoutes = <String, WidgetBuilder>{
  // NewUserWelcomePage.routeName: (context) => NewUserWelcomePage(),
  // ProfileSetupPage.routeName: (context) => ProfileSetupPage(),
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  ProfilePage.routeName: (context) => ProfilePage(),
  EventPage.routeName: (context) => EventPage(),
  TokenPage.routeName: (context) => TokenPage(),
  ConversationPage.routeName: (context) => ConversationPage(),
  ConversationDebug.routeName: (context) => ConversationDebug(),
  MessagePage.routeName: (context) => MessagePage(),
  DirectoryPage.routeName: (context) => DirectoryPage(),
  KeyPage.routeName: (context) => KeyPage(),
  AddSubscriptionPage.routeName: (context) => AddSubscriptionPage(),
  SubscriptionPage.routeName: (context) => SubscriptionPage(),
  CalendarAddEventPage.routeName: (context) => CalendarAddEventPage(),
  // NavigationPage.routeName: (context) => NavigationPage(),
};
