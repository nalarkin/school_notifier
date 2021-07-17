import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/view/view.dart';
import 'package:school_notifier/profile_setup/view/view.dart';
import '../navigation.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationNewParentSetup) {
          Navigator.pushNamed(context, ProfileSetupPage.routeName);
          // Navigator.of(context).push(ProfileSetupPage.route());
        } else if (state is NavigationParentSignInSuccess) {
          //  Navigator.of(context).push(HomePage.route());
          Navigator.pushNamed(context, HomePage.routeName);
        } else if (state is NavigationInitial) {
          ///
          Navigator.pushNamed(context, LoginPage.routeName);
          // Navigator.of(context).push(LoginPage.route());
        }
      },
      // child: Container(child: Text('loading...')),
      child: LoadingIndicator(),
    );
  }
}
