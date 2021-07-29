import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/calendar/calendar.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/profile/bloc/profile_bloc.dart';
import 'package:users_repository/users_repository.dart';

class CalendarCreateEventForm extends StatelessWidget {
  const CalendarCreateEventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarCubit, CalendarState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          /// can show success message if desired
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              Text('Select the classes that the event is for.'),
              _SubscriptionList(),

              _TitleInput(),
              const SizedBox(height: 8.0),
              _DatePicker(),
              const SizedBox(height: 8.0),
              _TimePicker(),
              const SizedBox(height: 8.0),

              // _DayInput(),
              // const SizedBox(height: 8.0),
              // _MonthInput(),
              // const SizedBox(height: 8.0),
              // _YearInput(),
              // const SizedBox(height: 8.0),
              // _TimeStartInput(),
              const SizedBox(height: 8.0),
              _DurationInput(),
              const SizedBox(height: 8.0),
              _DescriptionInput(),
              const SizedBox(height: 8.0),
              // _SubscriptionIdInput(),

              // _TypeInput(),
              // const SizedBox(height: 8.0),
              _SubmitEventButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventTitle != current.eventTitle,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (eventTitle) =>
              context.read<CalendarCubit>().eventTitleChanged(eventTitle),
          decoration: InputDecoration(
            labelText: 'Title',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid title' : null,
          ),
        );
      },
    );
  }
}

class _TimePicker extends StatelessWidget {
  const _TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('Event Start Time'),
        BlocBuilder<CalendarCubit, CalendarState>(
          buildWhen: (previous, current) =>
              previous.eventTimeStart != current.eventTimeStart,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(child: Container()),
                Container(
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(1)),
                  //     border: Border.symmetric(
                  //         horizontal:
                  //             BorderSide(color: Colors.black, width: 1))),
                  child: ElevatedButton(
                    // style: ButtonStyle(shape: ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: const Color(0xFFFFD600),
                    ),
                    onPressed: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      context
                          .read<CalendarCubit>()
                          .timeDialogueChanged(selectedTime);
                    },
                    child: state.eventTimeStart.value.isEmpty
                        ? Text('Select a Time', style: theme.textTheme.button)
                        : Text(
                            '${state.eventTimeStart.value}',
                            style: theme.textTheme.button,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
        // MaterialButton(
        //   onPressed: () async {
        //     TimeOfDay? selectedTime = await showTimePicker(
        //       initialTime: TimeOfDay.now(),
        //       context: context,
        //     );
        //     context.read<CalendarCubit>().timeDialogueChanged(selectedTime);
        //   },
        //   child: Text('c event time'),
        // ),
      ],
    );
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('Event Date Picker'),
        BlocBuilder<CalendarCubit, CalendarState>(
          buildWhen: (previous, current) =>
              previous.eventSelectedDay != current.eventSelectedDay,
          //     ('${event.}'),
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(child: Container()),
                Container(
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(1)),
                  //     border: Border.symmetric(
                  //         horizontal:
                  //             BorderSide(color: Colors.black, width: 1))),
                  child: ElevatedButton(
                    // style: ButtonStyle(shape: ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: const Color(0xFFFFD600),
                    ),
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.utc(2030, 1, 1));
                      print(selectedDate.toString());
                      context
                          .read<CalendarCubit>()
                          .eventSelectedDateChanged(selectedDate);

                      print(formatCalendarDate(selectedDate ?? DateTime.now()));
                      //  DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:  DateTime.utc(2030, 1, 1)
                      // context
                      //     .read<CalendarCubit>()
                      //     .timeDialogueChanged(selectedDate);
                    },
                    child: state.eventSelectedDay != null
                        ? Text(
                            '${formatCalendarDate(state.eventSelectedDay!)}',
                            style: theme.textTheme.button,
                          )
                        : Text(
                            'Select a Date',
                            style: theme.textTheme.button,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
        // MaterialButton(
        //   onPressed: () async {
        //     TimeOfDay? selectedTime = await showTimePicker(
        //       initialTime: TimeOfDay.now(),
        //       context: context,
        //     );
        //     context.read<CalendarCubit>().timeDialogueChanged(selectedTime);
        //   },
        //   child: Text('c event time'),
        // ),
      ],
    );
  }
}

// class _DayInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) => previous.eventDay != current.eventDay,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (day) =>
//               context.read<CalendarCubit>().eventDayChanged(day),
//           decoration: InputDecoration(
//             labelText: 'DD',
//             helperText: '',
//             errorText: state.eventTitle.invalid ? 'invalid Day' : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventDescription != current.eventDescription,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (description) => context
              .read<CalendarCubit>()
              .eventDescriptionChanged(description),
          decoration: InputDecoration(
            labelText: 'Description (optional)',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Description' : null,
          ),
        );
      },
    );
  }
}

// class _YearInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) => previous.eventYear != current.eventYear,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (year) =>
//               context.read<CalendarCubit>().eventYearChanged(year),
//           decoration: InputDecoration(
//             labelText: 'YY',
//             helperText: '',
//             errorText: state.eventTitle.invalid ? 'invalid Year' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _MonthInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) =>
//           previous.eventMonth != current.eventMonth,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (month) =>
//               context.read<CalendarCubit>().eventMonthChanged(month),
//           decoration: InputDecoration(
//             labelText: 'MM',
//             helperText: '',
//             errorText: state.eventTitle.invalid ? 'invalid Month' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _TimeStartInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) =>
//           previous.eventTimeStart != current.eventTimeStart,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (timeStart) =>
//               context.read<CalendarCubit>().eventTimeStartChanged(timeStart),
//           decoration: InputDecoration(
//             labelText: 'HH: MM',
//             helperText: '',
//             errorText:
//                 state.eventTitle.invalid ? 'invalid starting time' : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _DurationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventDuration != current.eventDuration,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (duration) =>
              context.read<CalendarCubit>().eventDurationChanged(duration),
          decoration: InputDecoration(
            labelText: 'Duration (minutes)',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Duration' : null,
          ),
        );
      },
    );
  }
}

// class _SubscriptionIdInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     FirestoreUser currUser = context.watch<ProfileBloc>().state.user;
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) =>
//           previous.eventSubscriptionId != current.eventSubscriptionId,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (subscriptionId) => context
//               .read<CalendarCubit>()
//               .eventSubscriptionIdChanged(subscriptionId),
//           decoration: InputDecoration(
//             labelText: 'SubscriptionId',
//             helperText: '',
//             errorText:
//                 state.eventTitle.invalid ? 'invalid SubscriptionId' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _SubscriptionList extends StatelessWidget {
//   const _SubscriptionList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> classes =
//         context.watch<ProfileBloc>().state.user.classes ?? {};
//     List<String> keyList = classes.keys.toList();
//     List<String> valueList = List.from(classes.values.toList());
//     return Container(
//         height: keyList.length * 50,
//         child: ListView.builder(
//             itemCount: keyList.length,
//             itemBuilder: (context, index) {
//               return BlocBuilder<CalendarCubit, CalendarState>(
//                 buildWhen: (previous, current) =>
//                     previous.eventSubscriptionList !=
//                     current.eventSubscriptionList,
//                 builder: (context, state) {
//                   // print('rebuilt here');
//                   bool value =
//                       state.eventSubscriptionList.contains(keyList[index]);
//                   return InkWell(
//                     onTap: () {
//                       // print('you pressed the inkwell!');
//                       context
//                           .read<CalendarCubit>()
//                           .toggleSubscription(keyList[index]);
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(child: Text('${valueList[index]}')),
//                           Checkbox(
//                             value: value,
//                             onChanged: (bool? newValue) {
//                               // print('you pressed the checkbox!');
//                               context
//                                   .read<CalendarCubit>()
//                                   .toggleSubscription(keyList[index]);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }));
//   }
// }
class _SubscriptionList extends StatelessWidget {
  const _SubscriptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> classes =
        context.watch<ProfileBloc>().state.user.classes ?? {};
    final List<String> keyList = classes.keys.toList();
    final List<String> valueList = List.from(classes.values.toList());
    return Container(
      child: Column(
        children: [
          for (final key in keyList)
            BlocBuilder<CalendarCubit, CalendarState>(
              buildWhen: (previous, current) =>
                  previous.eventSubscriptionList !=
                  current.eventSubscriptionList,
              builder: (context, state) {
                // print('rebuilt here');
                bool value = state.eventSubscriptionList.contains(key);
                return InkWell(
                  onTap: () {
                    // print('you pressed the inkwell!');
                    context.read<CalendarCubit>().toggleSubscription(key);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text('${classes[key]}')),
                        Checkbox(
                          value: value,
                          onChanged: (bool? newValue) {
                            // print('you pressed the checkbox!');
                            context
                                .read<CalendarCubit>()
                                .toggleSubscription(key);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
        ],
      ),
    );
    // );
  }
}
// class _SubscriptionList extends StatelessWidget {
//   const _SubscriptionList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> classes =
//         context.watch<ProfileBloc>().state.user.classes ?? {};
//     List<String> keyList = classes.keys.toList();
//     List<String> valueList = List.from(classes.values.toList());
//     return Container(
//         height: keyList.length * 50,
//         child: ListView.builder(
//             itemCount: keyList.length,
//             itemBuilder: (context, index) {
//               return BlocBuilder<CalendarCubit, CalendarState>(
//                 buildWhen: (previous, current) =>
//                     previous.eventSubscriptionList !=
//                     current.eventSubscriptionList,
//                 builder: (context, state) {
//                   // print('rebuilt here');
//                   bool value =
//                       state.eventSubscriptionList.contains(keyList[index]);
//                   return InkWell(
//                     onTap: () {
//                       // print('you pressed the inkwell!');
//                       context
//                           .read<CalendarCubit>()
//                           .toggleSubscription(keyList[index]);
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(child: Text('${valueList[index]}')),
//                           Checkbox(
//                             value: value,
//                             onChanged: (bool? newValue) {
//                               // print('you pressed the checkbox!');
//                               context
//                                   .read<CalendarCubit>()
//                                   .toggleSubscription(keyList[index]);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }));
//   }
// }

class _SubscriptionIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> classes =
        context.watch<ProfileBloc>().state.user.classes ?? {};
    print('${classes}');
    print('${classes.keys}');
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventSubscriptionList != current.eventSubscriptionList,
      builder: (context, state) {
        // print('rebuilt here');
        bool value =
            state.eventSubscriptionList.contains('test3GGiv2Bv3LpUr8qb');
        return InkWell(
          onTap: () {
            print('you pressed the inkwell!');
            context
                .read<CalendarCubit>()
                .toggleSubscription('test3GGiv2Bv3LpUr8qb');
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('select this class')),
                Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    print('you pressed the checkbox!');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// class _SubscriptionIdInput extends StatelessWidget {
//   String? dropdownValue = null;
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> classes =
//         context.watch<ProfileBloc>().state.user.classes ?? {};
//     print('${classes}');
//     print('${classes.keys}');
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       // buildWhen: (previous, current) =>
//       //     previous.eventSubscriptionId != current.eventSubscriptionId,

//       builder: (context, state) {
//         print('rebuilt here');
//         return DropdownButton<String>(
//           value: dropdownValue,
//           icon: const Icon(Icons.arrow_downward),
//           iconSize: 24,
//           elevation: 16,
//           style: const TextStyle(color: Colors.black),
//           underline: Container(
//             height: 2,
//             color: Colors.deepPurpleAccent,
//           ),
//           onChanged: (String? newValue) {
//             print(this.items);
//             print('onChanged newValue = $newValue');
//             print('onChanged classes[newValue] = ${classes[newValue]}');
//             // dropdownValue = '${currUser.classes?[newValue]}';
//             dropdownValue = '$newValue}';
//             context
//                 .read<CalendarCubit>()
//                 .eventSubscriptionIdChanged(newValue ?? '');
//           },
//           items: classes.keys
//               .toList()
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text('${value}'),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// class _TypeInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       buildWhen: (previous, current) => previous.eventType != current.eventType,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('eventCreation_eventTitleInput_textField'),
//           onChanged: (subscriptionId) =>
//               context.read<CalendarCubit>().eventTypeChanged(subscriptionId),
//           decoration: InputDecoration(
//             labelText: 'Type',
//             helperText: '',
//             errorText: state.eventTitle.invalid ? 'invalid Type' : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _SubmitEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.eventSubscriptionList != current.eventSubscriptionList,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated &&
                        state.eventSubscriptionList.isNotEmpty
                    ? () => context.read<CalendarCubit>().submitNewEvent()
                    : null,
                child: const Text('Submit Event'),
              );
      },
    );
  }
}
