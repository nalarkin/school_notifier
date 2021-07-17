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
    // return BlocBuilder<NavigationBloc, NavigationState>(

    //   builder: (context, state) {
    //     if (state is NavigationNewParentSetup) {
    //       return ProfileSetupPage();
    //     } else if (state is NavigationParentSignInSuccess) {
    //       return HomePage();
    //     } else if (state is NavigationInitial) {
    //       Navigator.pushNamed(context, LoginPage.routeName);
    //       return LoginPage();
    //     }
    //     return LoadingIndicator();
    //   },
    // );
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationNewParentSetup) {
          Navigator.pushNamed(context, ProfileSetupPage.routeName);
        } else if (state is NavigationParentSignInSuccess) {
          Navigator.pushNamed(context, ParentProfilePage.routeName);
          // Navigator.push(context, ParentProfilePage.route());
          // Navigator.pushNamed(context, HomePage.routeName);
        } else if (state is NavigationInitial) {
          Navigator.pushNamed(context, LoginPage.routeName);
        }
      },
      // child: Container(child: Text('loading...')),
      child: Builder(builder: (_) => Container()) ,

    );
  }
}
