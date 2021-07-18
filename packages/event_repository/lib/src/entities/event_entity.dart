import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  const EventEntity({
    required this.title,
    required this.description,
    required this.posterID,
    required this.posterPhoto,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventType,
    required this.eventPhoto,
    required this.eventSubscriptionID,
    required this.eventUID,
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

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'posterID': posterID,
      'posterPhoto': posterPhoto,
      'eventStartTime': eventStartTime,
      'eventEndTime': eventEndTime,
      'eventPhoto': eventPhoto,
      'eventType': eventType,
      'eventSubscriptionID': eventSubscriptionID,
      'eventUID': eventUID,
    };
  }

  @override
  List<Object> get props =>
      [eventUID, eventSubscriptionID, eventStartTime, eventEndTime, description, title];

  @override
  String toString() {
    return '''EventEntity { eventSubscriptionID: $eventSubscriptionID, title: $title, startTime: $eventStartTime, endTime: $eventEndTime, 
            ''';
  }

  static EventEntity fromJson(Map<String, Object> json) {
    return EventEntity(
      title: json['title'] as String,
      description: json['description'] as String,
      posterID: json['posterID'] as String,
      posterPhoto: json['posterPhoto'] as String,
      eventStartTime: (json['eventStartTime'] as Timestamp).toDate(),
      eventEndTime: (json['eventEndTime'] as Timestamp).toDate(),
      eventPhoto: json['eventPhoto'] as String,
      eventType: json['eventType'] as String,
      eventSubscriptionID: json['eventSubscriptionID'] as String,
      eventUID: json['eventUID'] as String,
    );
  }

  static EventEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return EventEntity(
      title: data['title'] as String,
      description: data['description'] as String,
      posterID: data['posterID'] as String,
      posterPhoto: data['posterPhoto'] as String,
      eventStartTime: (data['eventStartTime'] as Timestamp).toDate(),
      eventEndTime: (data['eventEndTime'] as Timestamp).toDate(),
      eventPhoto: data['eventPhoto'] as String,
      eventType: data['eventType'] as String,
      eventSubscriptionID: data['eventSubscriptionID'] as String,
      eventUID: data['eventUID'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'title': title,
      'description': description,
      'posterID': posterID,
      'posterPhoto': posterPhoto,
      'eventStartTime': eventStartTime,
      'eventEndTime': eventEndTime,
      'eventPhoto': eventPhoto,
      'eventType': eventType,
      'eventSubscriptionID': eventSubscriptionID,
      'eventUID': eventUID,
    };
  }
}
