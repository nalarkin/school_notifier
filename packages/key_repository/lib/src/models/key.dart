import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:key_repository/key_repository.dart';

class FirestoreKey extends Equatable {
  const FirestoreKey({
    this.creationDate,
    required this.id,
    this.isValid = true,
    required this.studentID,
     
  });

  final String? creationDate;
  final String id;
  final bool isValid;
  final String studentID;



  FirestoreKey copyWith(
      {String? creationDate,
      bool? isValid,
      String? studentID,}) {
    return FirestoreKey(
      creationDate: creationDate ?? this.creationDate,
      id: id,
      isValid: isValid ?? this.isValid,
      studentID: studentID ?? this.studentID,
    );
  }

  @override
  List<Object> get props =>
      [id, isValid];

  @override
  String toString() {
    return '''FirestoreKey { id: $id, studentId: $studentID isValid: $isValid, 
            creationDate: $creationDate}''';
  }

  KeyEntity toEntity() {
    return KeyEntity(
      creationDate: creationDate ?? DateTime.now().toString(),
      id: id,
      isValid: isValid ,
      studentID: studentID,
    );
  }

  static FirestoreKey fromEntity(KeyEntity entity) {
    return FirestoreKey(
      creationDate: entity.creationDate,
      id: entity.id,
      isValid: entity.isValid,
      studentID: entity.studentID,
    );
  }
}
