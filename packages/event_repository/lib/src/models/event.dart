import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../event_repository.dart';

class FirestoreEvent extends Equatable {
  const FirestoreEvent({
    required this.title,
    this.description = '',
    required this.posterID,
    this.posterPhoto = '',
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventType,
    this.eventPhoto = '',
    required this.eventSubscriptionID,
    this.eventUID = '',
  });

  final String title;
  final String description;
  final String posterID;
  final String posterPhoto;
  final DateTime eventStartTime;
  final DateTime eventEndTime;
  final String eventPhoto;
  final String eventType;
  final String eventSubscriptionID;
  final String eventUID;

  FirestoreEvent copyWith(
      {String? title,
      String? description,
      String? posterID,
      String? posterPhoto,
      DateTime? eventStartTime,
      DateTime? eventEndTime,
      String? eventPhoto,
      String? eventType,
      String? eventSubscriptionID,
      String? eventUID }) {
    return FirestoreEvent(
      title: title ?? this.title,
      description: description ?? this.description,
      posterID: posterID ?? this.posterID,
      posterPhoto: posterPhoto ?? this.posterPhoto,
      eventStartTime: eventStartTime ?? this.eventStartTime,
      eventEndTime: eventEndTime ?? this.eventEndTime,
      eventPhoto: eventPhoto ?? this.eventPhoto,
      eventType: eventType ?? this.eventType,
      eventSubscriptionID: eventSubscriptionID ?? this.eventSubscriptionID,
      eventUID: eventUID ?? this.eventUID,
    );
  }

  @override
  List<Object> get props =>
      [eventUID, eventSubscriptionID, eventStartTime, eventEndTime, description, title];

  @override
  String toString() {
    return '''FirestoreEvent { eventSubscriptionID: $eventSubscriptionID, title: $title, startTime: $eventStartTime, endTime: $eventEndTime, 
            ''';
  }

  EventEntity toEntity() {
    return EventEntity(
      title: title,
      description: description,
      posterID: posterID,
      posterPhoto: posterPhoto,
      eventStartTime: eventStartTime,
      eventEndTime: eventEndTime,
      eventPhoto: eventPhoto,
      eventType: eventType,
      eventSubscriptionID: eventSubscriptionID,
      eventUID: eventUID,
    );
  }

  static FirestoreEvent fromEntity(EventEntity entity) {
    return FirestoreEvent(
      title: entity.title,
      description: entity.description,
      posterID: entity.posterID,
      posterPhoto: entity.posterPhoto,
      eventStartTime: entity.eventStartTime,
      eventEndTime: entity.eventEndTime,
      eventPhoto: entity.eventPhoto,
      eventType: entity.eventType,
      eventSubscriptionID: entity.eventSubscriptionID,
      eventUID: entity.eventUID,
    );
  }
}
