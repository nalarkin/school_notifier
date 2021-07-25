import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:key_repository/key_repository.dart';

class FirestoreKey extends Equatable {
  const FirestoreKey({
    this.creationDate,
    this.id = '',
    this.isValid = true,
    this.isParent = false,
    this.isStudent = false,
    this.isTeacher = false,
    this.studentID = '',
    this.linkedUser = '', 
  });

  final String? creationDate;
  final String id;
  final bool isValid;
  final bool isParent;
  final bool isStudent;
  final bool isTeacher;
  final String linkedUser;
  final String studentID;

  FirestoreKey copyWith({
    String? creationDate,
    bool? isParent,
    bool? isStudent,
    bool? isTeacher,
    bool? isValid,
    String? studentID,
    String? linkedUser,
  }) {
    return FirestoreKey(
      creationDate: creationDate ?? this.creationDate,
      id: id,
      isParent: isParent ?? this.isParent,
      isStudent: isStudent ?? this.isStudent,
      isTeacher: isTeacher ?? this.isTeacher,
      isValid: isValid ?? this.isValid,
      studentID: studentID ?? this.studentID,
      linkedUser: linkedUser ?? this.linkedUser,
    );
  }

  @override
  List<Object> get props => [id, isValid];

  @override
  String toString() {
    return '''FirestoreKey { id: $id, studentId: $studentID isValid: $isValid, 
            isParent: $isParent, isStudent: $isStudent, isTeacher: $isTeacher, creationDate: $creationDate, linkedUser: $linkedUser}''';
  }

  KeyEntity toEntity() {
    return KeyEntity(
      creationDate: creationDate ?? DateTime.now().toString(),
      id: id,
      isParent: isParent,
      isStudent: isStudent,
      isTeacher: isTeacher,
      isValid: isValid,
      linkedUser: linkedUser,
      studentID: studentID,
    );
  }

  static FirestoreKey fromEntity(KeyEntity entity) {
    return FirestoreKey(
      creationDate: entity.creationDate,
      id: entity.id,
      isParent: entity.isParent,
      isStudent: entity.isStudent,
      isTeacher: entity.isTeacher,
      isValid: entity.isValid,
      linkedUser: entity.linkedUser,
      studentID: entity.studentID,
    );
  }
}
