import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/widgets/widgets.dart';
// import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:users_repository/users_repository.dart';

class AddSubscriptionPage extends StatelessWidget {
  const AddSubscriptionPage({Key? key}) : super(key: key);
  static const String routeName = '/subscription_page';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
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
              Text('Enter subscription UID'),
              _subscriptionNumberForm(context, _controller1),
              SizedBox(
                height: 40,
              ),
              Text('Enter name for subscription'),
              _subscriptionNameForm(context, _controller2),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    FirestoreUser currUser =
                        context.read<NavigationBloc>().state.user;
                    var subs = currUser.subscriptions;
                    if (subs == null) {
                      subs = {_controller1.text: _controller2.text};
                    } else {
                      subs[_controller1.text] = _controller2.text;
                    }
                    context
                        .read<FirestoreUserRepository>()
                        .updateUser(currUser.copyWith(subscriptions: subs));
                  },
                  child: Text('Submit new subscription'))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _subscriptionNumberForm(context, TextEditingController _controller1) {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            controller: _controller1,
          ),
        ),
      ],
    ),
  );
}

Widget _subscriptionNameForm(context, TextEditingController _controller2) {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            controller: _controller2,
          ),
        ),
      ],
    ),
  );
}
