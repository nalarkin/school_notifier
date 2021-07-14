import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users_repository/users_repository.dart';

class FirestoreParentsRepository implements UsersRepository {
  final parentsCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('parents')
      .collection('parents');

  @override
  Future<void> addNewUser(Parent user) {
    return parentsCollection.doc(user.id).set((user.toEntity().toDocument()));
  }

  @override
  Future<void> deleteUser(Parent user) async {
    return parentsCollection.doc(user.id).delete();
  }

  @override
  Stream<List<Parent>> users() {
    return parentsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Parent.fromEntity(ParentEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateUser(Parent user) {
    return parentsCollection.doc(user.id).update(user.toEntity().toDocument());
  }

  @override
  Future<Parent> getUserOrDefault(String id) async {
    try {
      final potentialUser = await parentsCollection.doc(id).get();
      if (potentialUser.exists) {
        return Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
      } else {
        return Parent.empty;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
