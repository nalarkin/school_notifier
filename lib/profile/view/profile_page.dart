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
            const SizedBox(height: 8.0),
            _FirstNameDisplay(),
            const SizedBox(height: 8.0),
            _LastNameDisplay(),
            const SizedBox(height: 8.0),
            _EmailDisplay(),
            const SizedBox(height: 8.0),
            _UserRoleDisplay(),
            const SizedBox(height: 40.0),
            _UserSubscriptionisplay(),
            const SizedBox(height: 8.0),
            _JoinDateDisplay(),
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
            // color: Colors.red,
            child: Text(
              state.user.firstName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
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
            // color: Colors.blue,
            child: Text(
              state.user.lastName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
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
            // color: Colors.green,
            child: Text(
              state.user.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
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
            // color: Colors.yellow,
            child: Text(
              'Join Date: ${DateFormat.yMMMd().format(state.user.joinDate ?? DateTime.now())}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black),
            ),
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
            // color: Colors.yellow,
            child: Text(
              'role: ${state.user.roleString}',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
          );
        });
  }
}

class _UserSubscriptionisplay extends StatelessWidget {
  const _UserSubscriptionisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.role != current.user.role,
        builder: (context, state) {
          return Container(
            // color: Colors.yellow,
            child: Text('Subscriptions: ${state.user.subscriptions?.values}'),
          );
        });
  }
}
