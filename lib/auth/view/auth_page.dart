import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/profile_setup/view/view.dart';
import '../auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNewParentSetup) {
          Navigator.pushNamed(context, ProfileSetupPage.routeName);
        } else if (state is AuthParentSignInSuccess) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      child: Container(),
    )
  }
}
