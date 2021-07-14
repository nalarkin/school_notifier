import 'package:flutter/widgets.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/profile_setup/profile_setup.dart';
import 'package:school_notifier/profile_setup/view/new_user_setup_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.parent:
      return [HomePage.page()];
    case AppStatus.newParent:
      return [NewUserWelcomePage.page()];
      // return [ProfileSetupPage.page()];
      
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
