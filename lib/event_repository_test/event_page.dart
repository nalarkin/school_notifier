import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);
  static const String routeName = '/event_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
              _AddNewEvent(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddNewEvent extends StatelessWidget {
  const _AddNewEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = FirestoreEvent(
      eventEndTime: DateTime.now(),
      eventStartTime: DateTime.now(),
      eventSubscriptionID: 'eventSubId',
      eventType: 'generalType',
      posterID: 'posterID',
      title: 'event-title',
      description: 'event-discrpition',
    );

    return TextButton(
        onPressed: () => context.read<EventRepository>().addNewEvent(event),
        child: Text('add new event'));
  }
}
