part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  const CalendarState({
    this.eventTitle = const EventTitle.pure(),
    this.eventDescription = const EventDescription.pure(),
    this.eventDay = const EventDay.pure(),
    this.eventMonth = const EventMonth.pure(),
    this.eventYear = const EventYear.pure(),
    this.eventSubscriptionId = const EventSubscriptionId.pure(),
    this.eventDuration = const EventDuration.pure(),
    this.status = FormzStatus.pure,
  });

  final EventTitle eventTitle;
  final EventDescription eventDescription;
  final EventDay eventDay;
  final EventMonth eventMonth;
  final EventYear eventYear;
  final EventSubscriptionId eventSubscriptionId;
  final EventDuration eventDuration;
  final FormzStatus status;

  @override
  List<Object> get props => [
        status,
        eventTitle,
        eventDescription,
        eventDay,
        eventMonth,
        eventYear,
        eventSubscriptionId,
        eventDuration,
      ];
  CalendarState copyWith({
    EventTitle? eventTitle,
    EventDescription? eventDescription,
    EventDay? eventDay,
    EventMonth? eventMonth,
    EventYear? eventYear,
    EventSubscriptionId? eventSubscriptionId,
    EventDuration? eventDuration,
    FormzStatus? status,
  }) {
    return CalendarState(
      status: status ?? this.status,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDay: eventDay ?? this.eventDay,
      eventMonth: eventMonth ?? this.eventMonth,
      eventYear: eventYear ?? this.eventYear,
      eventSubscriptionId: eventSubscriptionId ?? this.eventSubscriptionId,
      eventDuration: eventDuration ?? this.eventDuration,
    );
  }
}
