import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/login/login.dart';
// import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:users_repository/users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String routeName = '/profile_page';
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              key: const Key('profilePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (Route<dynamic> route) => false);
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              })
        ],
      ),
      body: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Avatar(),
            SizedBox(
              height: 8.0,
            ),
            _FirstNameDisplay(),
            _LastNameDisplay(),
            _EmailDisplay(),
            _JoinDateDisplay(),
            _UserRoleDisplay(),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, HomePage.routeName),
                child: Text("Cycle Back to Home")),
          ],
        ),
      ),
    );
  }
}

class _FirstNameDisplay extends StatelessWidget {
  const _FirstNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.firstName != current.user.firstName,
        builder: (context, state) {
          return Container(
            color: Colors.red,
            child: Text(state.user.firstName ?? ''),
          );
        });
  }
}

class _LastNameDisplay extends StatelessWidget {
  const _LastNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.lastName != current.user.lastName,
        builder: (context, state) {
          return Container(
            color: Colors.blue,
            child: Text(state.user.lastName ?? ''),
          );
        });
  }
}

class _EmailDisplay extends StatelessWidget {
  const _EmailDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.email != current.user.email,
        builder: (context, state) {
          return Container(
            color: Colors.green,
            child: Text(state.user.email ?? ''),
          );
        });
  }
}

class _JoinDateDisplay extends StatelessWidget {
  const _JoinDateDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.joinDate != current.user.joinDate,
        builder: (context, state) {
          return Container(
            color: Colors.yellow,
            child: Text(
                '${DateFormat.yMMMd().format(state.user.joinDate ?? DateTime.now())}'),
          );
        });
  }
}

class _UserRoleDisplay extends StatelessWidget {
  const _UserRoleDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.role != current.user.role,
        builder: (context, state) {
          return Container(
            color: Colors.yellow,
            child: Text('role: ${state.user.userRoleShortString}'),
          );
        });
  }
}


//           child: Text('${DateFormat.yMMMd().format(state.user.joinDate!)}'),
