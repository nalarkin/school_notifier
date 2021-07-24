import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/view/view.dart';
import 'package:school_notifier/profile/profile.dart';
// import 'package:school_notifier/profile_setup/view/view.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import '../navigation.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);
  // static const String routeName = '/nav';

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<NavigationBloc>().state.status;
    switch (currentState) {
      case NavigationStatus.parent:
        return HomePage();
      case NavigationStatus.unknown:
        return LoginPage();
      case NavigationStatus.newParent:
        return SignUpPage();
      case NavigationStatus.newParent:
        return SignUpPage();
      case NavigationStatus.tokenAuthorized:
        return SignUpPage();
      default:
        return LoginPage();
    }
  }
}
