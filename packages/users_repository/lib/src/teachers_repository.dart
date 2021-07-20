import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users_repository/users_repository.dart';

class TeachersRepository implements UsersRepository<Teacher> {
  final teachersCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('teachers')
      .collection('teachers');

  @override
  Future<void> addNewUser(Teacher user) {
    return teachersCollection.doc(user.id).set((user.toEntity().toDocument()));
  }

  @override
  Future<void> deleteUser(Teacher user) async {
    return teachersCollection.doc(user.id).delete();
  }

  @override
  Stream<List<Teacher>> users() {
    return teachersCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Teacher.fromEntity(TeacherEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateUser(Teacher user) {
    return teachersCollection.doc(user.id).update(user.toEntity().toDocument());
  }

  @override
  Future<Teacher> getUserOrDefault(String id) async {
    try {
      final potentialUser = await teachersCollection.doc(id).get();
      if (potentialUser.exists) {
        return Teacher.fromEntity(TeacherEntity.fromSnapshot(potentialUser));
      } else {
        return Teacher.empty;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Teacher?> getTeacherIfExists(String id) async {
    final potentialUser = await teachersCollection.doc(id).get();
    if (potentialUser.exists) {
      return Teacher.fromEntity(TeacherEntity.fromSnapshot(potentialUser));
    }
    return null;
  }

  @override
  Stream<Teacher> liveProfileStream(String id) {
    return teachersCollection
        .doc(id)
        .snapshots()
        .map((doc) => Teacher.fromEntity(TeacherEntity.fromSnapshot(doc)));
  }
}
