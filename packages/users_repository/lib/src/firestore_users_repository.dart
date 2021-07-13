import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users_repository/users_repository.dart';


class FirestoreUsersRepository implements UsersRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewUser(FirestoreUser user) {
    return usersCollection.doc(user.id).set((user.toEntity().toDocument()));
  }

  @override
  Future<void> deleteUser(FirestoreUser user) async {
    return usersCollection.doc(user.id).delete();
  }

  @override
  Stream<List<FirestoreUser>> users() {
    return usersCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FirestoreUser.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateUser(FirestoreUser user) {
    return usersCollection.doc(user.id).update(user.toEntity().toDocument());
  }
}
