import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class KeyEntity extends Equatable {
  const KeyEntity({
    required this.creationDate,
    required this.id,
    required this.isValid,
    required this.studentID,
  });

  final String creationDate;
  final String id;
  final bool isValid;
  final String studentID;

  Map<String, Object?> toJson() {
    return {
      'creationDate': creationDate,
      'id': id,
      'isValid': isValid,
      'studentID': studentID,
    };
  }

  @override
  List<Object> get props =>
      [id, isValid, studentID];

  @override
  String toString() {
    return '''KeyEntity { id: $id, studentID: $studentID, isValid: $isValid, 
            creationDate: $creationDate}''';
  }

  static KeyEntity fromJson(Map<String, Object> json) {
    return KeyEntity(
      creationDate: json['creationDate'].toString(),
      id: json['id'] as String,
      isValid: json['isValid'] as bool,
      studentID: json['studentID'] as String,
    );
  }

  static KeyEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return KeyEntity(
      creationDate: data['creationDate'].toString(),
      id: data['id'] as String,
      isValid: data['isValid'] as bool,
      studentID: data['studentID'] as String,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'creationDate': creationDate,
      'id': id,
      'isValid': isValid,
      'studentID': studentID,
    };
  }
}
