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
            // const SizedBox(height: 8.0),
            _EmailDisplay(),
            // const SizedBox(height: 8.0),
            _UserRoleDisplay(),

            _JoinDateDisplay(),
            // const SizedBox(height: 40.0),
            _UserSubscriptionisplay(),
            _RelatedChildrenDisplay(),
            _RelatedParentDisplay(),
            const SizedBox(height: 8.0),
            // _JoinDateDisplay(),
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
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.firstName != current.user.firstName,
        builder: (context, state) {
          return Container(
            // color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text('first:'),
                      Flexible(child: Container()),
                    ],
                  ),
                ),
                Text(
                  state.user.firstName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
}

class _LastNameDisplay extends StatelessWidget {
  const _LastNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.lastName != current.user.lastName,
        builder: (context, state) {
          return Container(
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text('last:'),
                      Flexible(child: Container()),
                    ],
                  ),
                ),
                Text(
                  state.user.lastName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
}

class _EmailDisplay extends StatelessWidget {
  const _EmailDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.email != current.user.email,
        builder: (context, state) {
          return Container(
            // color: Colors.green,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text('email:'),
                      Flexible(child: Container()),
                    ],
                  ),
                ),
                Text(
                  state.user.email ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
}

class _JoinDateDisplay extends StatelessWidget {
  const _JoinDateDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.joinDate != current.user.joinDate,
        builder: (context, state) {
          return Container(
            // color: Colors.yellow,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text('joined:'),
                      Flexible(child: Container()),
                    ],
                  ),
                ),
                Text(
                  '${DateFormat.yMMMd().format(state.user.joinDate ?? DateTime.now())}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
}

class _UserRoleDisplay extends StatelessWidget {
  const _UserRoleDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.role != current.user.role,
        builder: (context, state) {
          return Container(
            // color: Colors.yellow,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text('role:'),
                      Flexible(child: Container()),
                    ],
                  ),
                ),
                Text(
                  '${state.user.roleString}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
}

class _UserSubscriptionisplay extends StatelessWidget {
  const _UserSubscriptionisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.subscriptions != current.user.subscriptions,
        builder: (context, state) {
          final subs = state.user.subscriptions ?? {};
          if (subs.length == 0) return Container();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // color: Colors.yellow,
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Subscriptions:',
                //       style: theme.textTheme.bodyText2,
                //     ),
                //   ],
                // ),
                for (final sub in subs.values)
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            Text('class:'),
                            Flexible(child: Container()),
                          ],
                        ),
                      ),
                      Text(
                        '$sub',
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}

class _RelatedChildrenDisplay extends StatelessWidget {
  const _RelatedChildrenDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.children != current.user.children,
        builder: (context, state) {
          final children = state.user.children ?? {};
          if (children.length == 0) return Container();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // color: Colors.yellow,
            child: Column(
              children: [
                for (final child in children.values)
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            Text('child:'),
                            Flexible(child: Container()),
                          ],
                        ),
                      ),
                      Text(
                        '$child',
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}

class _RelatedParentDisplay extends StatelessWidget {
  const _RelatedParentDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            previous.user.parents != current.user.parents,
        builder: (context, state) {
          final parents = state.user.parents ?? {};
          if (parents.length == 0) return Container();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                color: theme.canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // color: Colors.yellow,
            child: Column(
              children: [
                for (final parent in parents.values)
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            Text('parent:'),
                            Flexible(child: Container()),
                          ],
                        ),
                      ),
                      Text(
                        '$parent',
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}
