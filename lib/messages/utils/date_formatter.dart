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

String formatDateEventTime(DateTime date) {
  return '${DateFormat.jm().format(date)}';
}
