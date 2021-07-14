import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import '../profile_setup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ProfileSetupPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Additional Info')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) =>
              ProfileSetupCubit(context.read<AuthenticationRepository>()),
          child: const ProfileSetupForm(),
        ),
      ),
    );
  }
}
