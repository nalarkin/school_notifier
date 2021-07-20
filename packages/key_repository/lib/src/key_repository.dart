import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:key_repository/key_repository.dart';

class KeyRepository {
  final keyCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('keys')
      .collection('keys');

  Future<FirestoreKey?> getKey(String keyId) async {
    try {
      final potentialKeyDoc = await keyCollection.doc(keyId).get();
      if (potentialKeyDoc.exists) {
        FirestoreKey key =
            FirestoreKey.fromEntity(KeyEntity.fromSnapshot(potentialKeyDoc));
        if (key.isValid) {
          return key;
        }
      }
    } catch (e) {
      print('Error in key_repository.dart. $e');
    }
    return null;
  }

  Future<void> updateKey(FirestoreKey key) async {
    await keyCollection.doc(key.id).update(key.toEntity().toDocument());
  }

  // Future<void> generateNewKeyFromStudentID(String studentID) async {
  //   try {
  //     final newKeyID = keyCollection.doc();
  //     FirestoreKey keyGenerated = FirestoreKey(
  //         id: newKeyID.id,
  //         creationDate: DateTime.now().toString(),
  //         isValid: true,
  //         studentID: studentID);
  //     keyCollection.doc(newKeyID.id).set(keyGenerated.toEntity().toJson());
  //   } catch (e) {
  //     print('Error in key_repository.dart. $e');
  //   }
  // }
  Future<void> _generateNewKeyFromID(
      {required String studentID,
      bool teacher = false,
      bool student = false,
      bool parent = false}) async {
    try {
      final newKeyID = keyCollection.doc();
      FirestoreKey keyGenerated = FirestoreKey(
          id: newKeyID.id,
          creationDate: DateTime.now().toString(),
          isParent: parent,
          isStudent: student,
          isTeacher: teacher,
          isValid: true,
          studentID: studentID);
      keyCollection.doc(newKeyID.id).set(keyGenerated.toEntity().toJson());
    } catch (e) {
      print('Error in key_repository.dart. $e');
    }
  }

  void generateNewStudentKeyFromStudentID(String studentID) {
    _generateNewKeyFromID(studentID: studentID, student: true);
  }
  void generateNewParentKeyFromStudentID(String studentID) {
    _generateNewKeyFromID(studentID: studentID, parent: true);
  }

  /// stores teacherID in studentID to save space
  void generateNewTeacherKeyFromTeacherID(String teacherID) {
    _generateNewKeyFromID(studentID: teacherID, teacher: true);
  }

  // Future<void> addNewUser(Parent user) {
  //   return parentsCollection.doc(user.id).set((user.toEntity().toDocument()));
  // }

  // Future<void> deleteUser(Parent user) async {
  //   return parentsCollection.doc(user.id).delete();
  // }

  // Stream<List<Parent>> users() {
  //   return parentsCollection.snapshots().map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => Parent.fromEntity(ParentEntity.fromSnapshot(doc)))
  //         .toList();
  //   });
  // }

  // Future<void> updateUser(Parent user) {
  //   return parentsCollection.doc(user.id).update(user.toEntity().toDocument());
  // }

  // Future<Parent> getUserOrDefault(String id) async {
  //   try {
  //     final potentialUser = await parentsCollection.doc(id).get();
  //     if (potentialUser.exists) {
  //       return Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
  //     } else {
  //       return Parent.empty;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Stream<Parent> liveProfileStream(String id) {
  //   return parentsCollection
  //       .doc(id)
  //       .snapshots()
  //       .map((doc) => Parent.fromEntity(ParentEntity.fromSnapshot(doc)));
  // }
}
// }
