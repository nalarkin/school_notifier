import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/event_repository_test/EventViewModel.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/widgets/widgets.dart';
// import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:rxdart/rxdart.dart';

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
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () => Navigator.push(context, EventList.route()),
                child: Text('see event list'),
              ),
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

// class EventList extends StatefulWidget {
//   EventList({Key? key}) : super(key: key);
//   // static Page page() => const MaterialPage<void>(child: EventList());
//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => EventList());
//   }

//   @override
//   _EventListState createState() => _EventListState();
// }

// class _EventListState extends State<EventList> {
//   final eventRepo = EventRepository();

//   late StreamSubscription _sub;

//   @override
//   void initState() {
//     super.initState();
//     _sub = eventRepo.getSingleStream('eventSubId').listen(print);
//   }

//   @override
//   void dispose() {
//     _sub.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoadingIndicator();
//   }
// }

class EventList extends StatelessWidget {
  const EventList({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: EventList());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const EventList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FirestoreEvent>>(
      // stream: context.read<EventRepository>().getSingleStream('eventSubId'),
      // stream: context
      //     .read<EventRepository>()
      //     .getAllSubscribedEvents(['eventSubId', 'eventSubId2']),
      // stream: CombineLatestStream(
      //     context
      //       .read<EventRepository>()
      //       .getAllSubscribedEvents(['eventSubId2', 'eventSubId'])),
      stream: EventViewModel(database: context.read<EventRepository>())
          .combineAllStreams(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              child: Column(
            children: [
              // Text('${snapshot.data}'),
              Text('${snapshot.connectionState}'),
              // Text('${snapshot.toString()}'),
              LoadingIndicator(),
            ],
          ));
        } else {
          List<FirestoreEvent>? data = snapshot.data;
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return buildTile(
                  context,
                  index,
                  data?[index] ??
                      FirestoreEvent(
                          title: 'title',
                          posterID: 'posterID',
                          eventStartTime: DateTime.now(),
                          eventEndTime: DateTime.now(),
                          eventType: 'eventType',
                          eventSubscriptionID: 'eventSubscriptionID'));
            },
          );
        }
      },
    );
  }
}

Widget buildTile(context, int index, FirestoreEvent event) {
  return Card(
    child: ListTile(
      title: Text(event.title),
      subtitle: Text(event.eventSubscriptionID),
    ),
  );
}
