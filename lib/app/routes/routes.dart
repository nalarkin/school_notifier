import 'package:flutter/widgets.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:school_notifier/profile_setup/view/new_user_setup_page.dart';
import 'package:school_notifier/authentication/authentication.dart';


List<Page> onGenerateAppViewPages(AuthenticationStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [HomePage.page()];
    case AuthenticationStatus.parent:
      return [HomePage.page()];
    case AuthenticationStatus.newParent:
      return [NewUserWelcomePage.page()];
      // return [ProfileSetupPage.page()];
      
    case AuthenticationStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
