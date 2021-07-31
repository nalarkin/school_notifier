import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_repository/event_repository.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/calendar/cubit/calendar_cubit.dart';
import 'package:school_notifier/calendar/view/calendar_create_event_form.dart';
import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/widgets/widgets.dart';
// import 'package:school_notifier/navigation/bloc/navigation_bloc.dart';
import 'package:users_repository/users_repository.dart';

class CalendarAddEventPage extends StatelessWidget {
  const CalendarAddEventPage({Key? key}) : super(key: key);
  static const String routeName = '/add_event';


  @override
  Widget build(BuildContext context) {
    final _selectedDate = ModalRoute.of(context)!.settings.arguments as DateTime;
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocProvider(
            create: (_) => CalendarCubit(context.read<EventRepository>(),
                context.read<NavigationBloc>().state.user.id,
                _selectedDate
                ),
                child: CalendarCreateEventForm(),),
      ),
    );
  }
}
