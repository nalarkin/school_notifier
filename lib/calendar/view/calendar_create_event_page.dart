import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/event_repository_test/EventViewModel.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/widgets/widgets.dart';
// import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:users_repository/users_repository.dart';

class CalendarAddEventPage extends StatefulWidget {
  const CalendarAddEventPage({Key? key}) : super(key: key);
  static const String routeName = '/add_event';

  @override
  _CalendarAddEventPageState createState() => _CalendarAddEventPageState();
}

class _CalendarAddEventPageState extends State<CalendarAddEventPage> {
  @override
  Widget build(BuildContext context) {
    final defaultDateToAdd =
        ModalRoute.of(context)!.settings.arguments as DateTime;

    final TextEditingController _dayController =
        TextEditingController(text: '${defaultDateToAdd.day}');
    final TextEditingController _monthController =
        TextEditingController(text: '${defaultDateToAdd.month}');
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an Event'),
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
              // BlocProvider.value(
              //   value: context.read<ProfileBloc>(),
              //   child: SelectClass(),
              // ),
              Container(
                // alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Day '),
                        SizedBox(
                          height: 5,
                        ),
                        _subscriptionNumberForm(context, _dayController),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text('Month'),
                        SizedBox(
                          height: 5,
                        ),
                        _monthForm(context, _monthController),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Title of Event'),
              _TitleForm(context, _titleController),
              Text('Description of Event (optional)'),
              _TitleForm(context, _descriptionController),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    print('setting state');
                    setState(() {});
                    // FirestoreUser currUser =
                    //     context.read<ProfileBloc>().state.user;
                    // FirestoreEvent _createdEvent = FirestoreEvent(
                    //     title: _titleController.text,
                    //     posterID: currUser.id,
                    //     eventStartTime: DateTime.now(),
                    //     eventEndTime: DateTime.now(),
                    //     eventType: 'eventType',
                    //     eventSubscriptionID: 'eventSubscriptionID');
                  },
                  child: Text('Submit new event'))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _subscriptionNumberForm(context, TextEditingController _controller) {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextFormField(
            controller: _controller,
          ),
        ),
      ],
    ),
  );
}

Widget _monthForm(context, TextEditingController _controller) {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextFormField(
            controller: _controller,
          ),
        ),
      ],
    ),
  );
}

Widget _TitleForm(context, TextEditingController _controller) {
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
            controller: _controller,
          ),
        ),
      ],
    ),
  );
}

Widget _DescriptionForm(context, TextEditingController _controller) {
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
            controller: _controller,
          ),
        ),
      ],
    ),
  );
}

// class SelectClass extends StatefulWidget {
//   const SelectClass({Key? key}) : super(key: key);

//   @override
//   _SelectClassState createState() => _SelectClassState();
// }

// class _SelectClassState extends State<SelectClass> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
