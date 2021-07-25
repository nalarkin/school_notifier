import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:users_repository/users_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/sign_up_page';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        actions: [
          // button
          TextButton(
              onPressed: () {
                context.read<NavigationBloc>().add(NavigationUnknown());
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (Route<dynamic> route) => false);
                // context.read<NavigationBloc>().add(NavigationUnknown());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cancel',
                    style: theme.textTheme.bodyText1
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
              context.read<AuthenticationRepository>(),
              context.read<KeyRepository>(),
              context.read<FirestoreUserRepository>(),
              context.read<NavigationBloc>().state.key),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
