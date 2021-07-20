import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class KeyEntity extends Equatable {
  const KeyEntity({
    required this.creationDate,
    required this.id,
    required this.isParent,
    required this.isStudent,
    required this.isTeacher,
    required this.isValid,
    required this.linkedUser,
    required this.studentID,
  });

  final String creationDate;
  final String id;
  final bool isParent;
  final bool isStudent;
  final bool isTeacher;
  final bool isValid;
  final String linkedUser;
  final String studentID;

  Map<String, Object?> toJson() {
    return {
      'creationDate': creationDate,
      'id': id,
      'isParent': isParent,
      'isStudent': isStudent,
      'isTeacher': isTeacher,
      'isValid': isValid,
      'linkedUser': linkedUser,
      'studentID': studentID,
    };
  }

  @override
  List<Object> get props => [id, isValid, studentID];

  @override
  String toString() {
    return '''KeyEntity { id: $id, studentID: $studentID, isValid: $isValid, 
            creationDate: $creationDate}''';
  }

  static KeyEntity fromJson(Map<String, Object> json) {
    return KeyEntity(
      creationDate: json['creationDate'].toString(),
      id: json['id'] as String,
      isParent: json['isParent'] as bool,
      isStudent: json['isStudent'] as bool,
      isTeacher: json['isTeacher'] as bool,
      isValid: json['isValid'] as bool,
      linkedUser: json['linkedUser'] as String,
      studentID: json['studentID'] as String,
    );
  }

  static KeyEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) throw Exception();
    return KeyEntity(
      creationDate: data['creationDate'].toString(),
      id: data['id'] as String,
      isParent: data['isParent'] as bool,
      isStudent: data['isStudent'] as bool,
      isTeacher: data['isTeacher'] as bool,
      isValid: data['isValid'] as bool,
      linkedUser: data['linkedUser'] as String,
      studentID: data['studentID'] as String,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'creationDate': creationDate,
      'id': id,
      'isParent': isParent,
      'isStudent': isStudent,
      'isTeacher': isTeacher,
      'isValid': isValid,
      'studentID': studentID,
      'linkedUser': linkedUser,
    };
  }
}
