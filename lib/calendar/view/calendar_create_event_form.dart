import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/calendar/calendar.dart';
import 'package:formz/formz.dart';

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
              _TitleInput(),
              const SizedBox(height: 8.0),
              _DayInput(),
              const SizedBox(height: 8.0),
              _MonthInput(),
              const SizedBox(height: 8.0),
              _YearInput(),
              const SizedBox(height: 8.0),
              _TimeStartInput(),
              const SizedBox(height: 8.0),
              _DurationInput(),
              const SizedBox(height: 8.0),
              _DescriptionInput(),
              const SizedBox(height: 8.0),
              _SubscriptionIdInput(),
              _TypeInput(),
              const SizedBox(height: 8.0),
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

class _DayInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) => previous.eventDay != current.eventDay,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (day) =>
              context.read<CalendarCubit>().eventDayChanged(day),
          decoration: InputDecoration(
            labelText: 'DD',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Day' : null,
          ),
        );
      },
    );
  }
}

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
            labelText: 'Description',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Description' : null,
          ),
        );
      },
    );
  }
}

class _YearInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) => previous.eventYear != current.eventYear,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (year) =>
              context.read<CalendarCubit>().eventYearChanged(year),
          decoration: InputDecoration(
            labelText: 'YY',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Year' : null,
          ),
        );
      },
    );
  }
}

class _MonthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventMonth != current.eventMonth,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (month) =>
              context.read<CalendarCubit>().eventMonthChanged(month),
          decoration: InputDecoration(
            labelText: 'MM',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Month' : null,
          ),
        );
      },
    );
  }
}

class _TimeStartInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventTimeStart != current.eventTimeStart,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (timeStart) =>
              context.read<CalendarCubit>().eventTimeStartChanged(timeStart),
          decoration: InputDecoration(
            labelText: 'HH: MM',
            helperText: '',
            errorText:
                state.eventTitle.invalid ? 'invalid starting time' : null,
          ),
        );
      },
    );
  }
}

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
            labelText: 'Duration',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Duration' : null,
          ),
        );
      },
    );
  }
}

class _SubscriptionIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.eventSubscriptionId != current.eventSubscriptionId,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (subscriptionId) => context
              .read<CalendarCubit>()
              .eventSubscriptionIdChanged(subscriptionId),
          decoration: InputDecoration(
            labelText: 'SubscriptionId',
            helperText: '',
            errorText:
                state.eventTitle.invalid ? 'invalid SubscriptionId' : null,
          ),
        );
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) => previous.eventType != current.eventType,
      builder: (context, state) {
        return TextField(
          key: const Key('eventCreation_eventTitleInput_textField'),
          onChanged: (subscriptionId) =>
              context.read<CalendarCubit>().eventTypeChanged(subscriptionId),
          decoration: InputDecoration(
            labelText: 'Type',
            helperText: '',
            errorText: state.eventTitle.invalid ? 'invalid Type' : null,
          ),
        );
      },
    );
  }
}

class _SubmitEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) => previous.status != current.status,
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
                onPressed: state.status.isValidated
                    ? () => context.read<CalendarCubit>().submitNewEvent()
                    : null,
                child: const Text('Submit Event'),
              );
      },
    );
  }
}
