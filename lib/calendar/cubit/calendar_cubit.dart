import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._eventRepository, this._posterId)
      : super(const CalendarState());
  EventRepository _eventRepository;
  String _posterId;

  void eventTitleChanged(String value) {
    final eventTitle = EventTitle.dirty(value);
    emit(state.copyWith(
      eventTitle: eventTitle,
      status: Formz.validate([
        eventTitle,
        state.eventDay,
        state.eventDuration,
        // state.eventSubscriptionId,
        state.eventDescription,
        state.eventMonth,
        state.eventTimeStart,
        state.eventType,
        state.eventYear,
      ]),
    ));
  }

  void eventTimeStartChanged(String value) {
    final eventTimeStart = EventTimeStart.dirty(value);
    emit(state.copyWith(
      eventTimeStart: eventTimeStart,
      status: Formz.validate([
        eventTimeStart,
        state.eventTitle,
        state.eventDay,
        state.eventDuration,
        // state.eventSubscriptionId,
        state.eventDescription,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
        state.eventType,
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
        // state.eventSubscriptionId,
        state.eventDescription,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
        state.eventType,
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
        // state.eventSubscriptionId,
        state.eventDescription,
        state.eventTitle,
        state.eventYear,
        state.eventTimeStart,
        state.eventType,
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
        state.eventDescription,
        state.eventTitle,
        // state.eventSubscriptionId,
        state.eventMonth,
        state.eventTimeStart,
        state.eventTitle,
        state.eventType,
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
        state.eventDescription,
        state.eventTitle,
        // state.eventSubscriptionId,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
        state.eventType,
      ]),
    ));
  }

  void timeDialogueChanged(TimeOfDay? value) {
    if (value != null) {
      print('time received ${value.toString()}');
      final timeStart = EventTimeStart.dirty('${value.hour}:${value.minute}');
      emit(state.copyWith(
        eventTimeStart: timeStart,
        status: Formz.validate([
          timeStart,
          state.eventTitle,
          state.eventDescription,
          state.eventTitle,
          // state.eventSubscriptionId,
          state.eventMonth,
          state.eventTimeStart,
          state.eventYear,
          state.eventType,
        ]),
      ));
    }
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
        state.eventType,
        // state.eventSubscriptionId,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
      ]),
    ));
  }

  void eventTypeChanged(String value) {
    final eventType = EventType.dirty(value);
    // print('');
    // final typeStatus = Formz.validate([eventType]);
    // final eventDayStatus = Formz.validate([state.eventDay]);
    // final eventDescription = Formz.validate([state.eventDescription]);
    // final eventMonth = Formz.validate([state.eventMonth]);
    // final eventTitle = Formz.validate([state.eventTitle]);
    // final eventSubscriptionId = Formz.validate([state.eventSubscriptionId]);
    // final eventYear = Formz.validate([state.eventYear]);
    // final eventTimeStart = Formz.validate([state.eventTimeStart]);
    // final res = [
    //   typeStatus,
    //   eventDayStatus,
    //   eventDescription,
    //   eventMonth,
    //   eventTitle,
    //   eventSubscriptionId,
    //   eventYear,
    //   eventTimeStart
    // ];
    // print(res);
    // print('$typeStatus');
    // print('$eventDayStatus');
    // print('$eventDescription');
    // print('$eventDay');
    // print('$eventTitle');
    // print('$eventSubscriptionId');
    // print('$eventYear');
    // print('$eventTimeStart');

    // final typeStatus = Formz.validate([eventType]);
    emit(state.copyWith(
      eventType: eventType,
      status: Formz.validate([
        eventType,
        state.eventDuration,
        state.eventDescription,
        state.eventDay,
        state.eventTitle,
        // state.eventSubscriptionId,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
      ]),
    ));
  }

  // void eventSubscriptionIdChanged(String value) {
  //   final subscriptionId = EventSubscriptionId.dirty(value);
  //   emit(state.copyWith(
  //     eventSubscriptionId: subscriptionId,
  //     status: Formz.validate([
  //       subscriptionId,
  //       state.eventDuration,
  //       state.eventDescription,
  //       state.eventDay,
  //       state.eventTitle,
  //       state.eventSubscriptionId,
  //       state.eventMonth,
  //       state.eventTimeStart,
  //       state.eventYear,
  //     ]),
  //   ));
  // }

  void toggleSubscription(String value) {
    var _newList = state.eventSubscriptionList.toList();
    print('list before change = $_newList');
    if (_newList.contains(value)) {
      _newList.remove(value);
    } else {
      _newList.add(value);
    }
    print('Newly created sub list is $_newList');
    print('Value is  $value');
    emit(state.copyWith(
      eventSubscriptionList: _newList,
      status: Formz.validate([
        // state.eventSubscriptionId,
        state.eventDuration,
        state.eventDescription,
        state.eventDay,
        state.eventTitle,
        // state.eventSubscriptionId,
        state.eventMonth,
        state.eventTimeStart,
        state.eventYear,
      ]),
    ));
  }

  Future<void> submitNewEvent() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final startTime = convertStringToDateTime(
          state.eventDay.value,
          state.eventMonth.value,
          state.eventYear.value,
          state.eventTimeStart.value);
      final duration = int.tryParse(state.eventDuration.value);
      if (startTime != null && duration != null) {
        final endTime = startTime.add(Duration(minutes: duration));
        FirestoreEvent newEvent = FirestoreEvent(
          eventEndTime: endTime,
          eventStartTime: startTime,
          eventSubscriptionID: '',
          title: state.eventTitle.value,
          description: state.eventDescription.value,
          posterID: _posterId,
          eventType: state.eventType.value,
        );
        final _listOfEvents = <FirestoreEvent>[
          for (final subId in state.eventSubscriptionList)
            newEvent.copyWith(eventSubscriptionID: subId)
        ];
        await _eventRepository.storeListOfEvents(_listOfEvents);

        // for (String subId in state.eventSubscriptionList) {
        //   await _eventRepository
        //       .addNewEvent(newEvent.copyWith(eventSubscriptionID: subId));
        // }
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

DateTime? convertStringToDateTime(
    String day, String month, String year, String time) {
  return DateTime.tryParse('20$year-$month-$day $time');
}
