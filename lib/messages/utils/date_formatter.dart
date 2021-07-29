import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateString(DateTime date, DateTime currentDate) {
  final difference = currentDate.difference(date);
  if (difference >= Duration(days: 30)) {
    return '${DateFormat.yMd().format(date)}';
  } else if (difference >= Duration(days: 7)) {
    return '${DateFormat.Md().format(date)}';
  } else if (difference >= Duration(days: 1)) {
    return '${DateFormat.E().format(date)}';
  }

  return '${DateFormat.jm().format(date)}';
}

String formatDateEventWeekday(DateTime date) {
  return '${DateFormat.E().add_MMMd().format(date)}';
}

String formatCalendarDate(DateTime date) {
  return '${DateFormat.MMMEd().format(date)}';
}

String formatTimeOfDay(TimeOfDay date) {
  final String hour = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
  final String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
  return '$hour:$minute';
}

String formatDateEventTime(DateTime date) {
  return '${DateFormat.jm().format(date)}';
}
// String formatDateEventTime(DateTime date) {
//   DateFormat newFormat = DateFormat('h:mm');
//   return '${newFormat.format(date)}';
// }

/// Returns a time range for event if event duration is greater than 1 minute
/// Returns a single time value if difference is <= 1 minute.
String formatDateEventStartToEndTime(DateTime start, DateTime end) {
  DateFormat startFormat = DateFormat('h:mm');
  DateFormat endFormat = DateFormat('h:mm a');

  if (start.difference(end).abs() > Duration(minutes: 1)) {
    return '${startFormat.format(start)}-${endFormat.format(end)}';
  }

  return '${endFormat.format(start)}';

  // return '${DateFormat.jm().format(start)}';
}

// String formatEventTimeRange(DateTime start, )