import 'package:flutter/widgets.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/event_repository_test/event_page.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:school_notifier/profile_setup/view/new_user_setup_page.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/sign_up/sign_up.dart';


Map<String, WidgetBuilder> allRoutes = <String, WidgetBuilder>{
  NewUserWelcomePage.routeName: (context) => NewUserWelcomePage(),
  ProfileSetupPage.routeName: (context) => ProfileSetupPage(),
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  // ParentProfilePage.routeName: (context) => ParentProfilePage(),
  EventPage.routeName: (context) => EventPage(),

};
