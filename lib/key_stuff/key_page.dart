import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/widgets/widgets.dart';
// import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:rxdart/rxdart.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({Key? key}) : super(key: key);
  static const String routeName = '/key_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            key: const Key('profilePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
              ),
              _AddNewKey(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}

class _AddNewKey extends StatelessWidget {
  const _AddNewKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => context
            .read<KeyRepository>()
            .generateNewTeacherKeyFromTeacherID(''),
        child: Text('add new key'));
  }
}
