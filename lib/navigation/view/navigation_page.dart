import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/view/view.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/profile_setup/view/view.dart';
import '../navigation.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (context.watch<NavigationBloc>().state.status) {
      case NavigationStatus.parent:
        return HomePage();
      case NavigationStatus.unknown:
        return LoginPage();
      case NavigationStatus.newParent:
        return ProfileSetupForm();
      default:
        return LoginPage();
    }
  }
}