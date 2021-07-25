import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:school_notifier/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  Map<DateTime, List<Event>> eventBuilder = Map();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeend;
  TextEditingController _eventController = TextEditingController();
  @override
  void initState() {
    eventBuilder = {};
    _selectedDay = _focusedDate;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return eventBuilder[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher\'s Calendar'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2014, 03, 01),
            lastDay: DateTime.utc(2030, 10, 30),
            focusedDay: _focusedDate,
            calendarFormat: _calendarFormat,
            //eventLoader: _selectedEvents,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDate = focusedDay;
                });
              }
            },
            eventLoader: _getEventsForDay,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },
          ),
          ..._getEventsForDay(_focusedDate).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Add Event"),
          icon: Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Add Event"),
                    content: TextFormField(
                      decoration: InputDecoration(hintText: 'Type an event'),
                      controller: _eventController,
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () => {
                                if (_eventController.text.isEmpty)
                                  {
                                    Navigator.pop(context, 'Ok'),
                                  }
                                else
                                  {
                                    if (eventBuilder[_focusedDate] != null)
                                      {
                                        eventBuilder[_focusedDate]!
                                            .add(Event(_eventController.text)),
                                      }
                                    else
                                      {
                                        eventBuilder[_focusedDate] = [
                                          Event(_eventController.text)
                                        ]
                                      }
                                  },
                                Navigator.pop(context),
                                _eventController.clear(),
                                setState(() {}),
                              },

                          //Navigator.pop(context, 'Ok'),
                          child: const Text("Ok"))
                    ],
                  ))),
    );
  }
}
