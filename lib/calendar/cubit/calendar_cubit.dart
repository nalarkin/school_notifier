import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_repository/event_repository.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._eventRepository) : super(const CalendarState());
  EventRepository _eventRepository;

  void eventTitleChanged(String value) {
    final eventTitle = EventTitle.dirty(value);
    emit(state.copyWith(
      eventTitle: eventTitle,
      status: Formz.validate([
        eventTitle,
        state.eventDay,
        state.eventDuration,
        state.eventSubscriptionId,
        state.eventMonth,
        state.eventYear
      ]),
    ));
  }

  void eventDurationChanged(String value) {
    final eventDuration = EventDuration.dirty(value);
    emit(state.copyWith(
      eventDuration: eventDuration,
      status: Formz.validate([
        eventDuration,
        state.eventDay,
        state.eventTitle,
        state.eventSubscriptionId,
        state.eventMonth,
        state.eventYear
      ]),
    ));
  }

  void eventMonthChanged(String value) {
    final eventMonth = EventMonth.dirty(value);
    emit(state.copyWith(
      eventMonth: eventMonth,
      status: Formz.validate([
        eventMonth,
        state.eventDay,
        state.eventTitle,
        state.eventSubscriptionId,
        state.eventTitle,
        state.eventYear
      ]),
    ));
  }

  void eventYearChanged(String value) {
    final eventYear = EventYear.dirty(value);
    emit(state.copyWith(
      eventYear: eventYear,
      status: Formz.validate([
        eventYear,
        state.eventDay,
        state.eventTitle,
        state.eventSubscriptionId,
        state.eventMonth,
        state.eventTitle
      ]),
    ));
  }

  void eventDayChanged(String value) {
    final eventDay = EventDay.dirty(value);
    emit(state.copyWith(
      eventDay: eventDay,
      status: Formz.validate([
        eventDay,
        state.eventTitle,
        state.eventTitle,
        state.eventSubscriptionId,
        state.eventMonth,
        state.eventYear
      ]),
    ));
  }

  void eventDescriptionChanged(String value) {
    final eventDescription = EventDescription.dirty(value);
    emit(state.copyWith(
      eventDescription: eventDescription,
      status: Formz.validate([
        eventDescription,
        state.eventDuration,
        state.eventDay,
        state.eventTitle,
        state.eventSubscriptionId,
        state.eventMonth,
        state.eventYear
      ]),
    ));
  }

  Future<void> submitNewEvent() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
