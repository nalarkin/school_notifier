// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:users_repository/users_repository.dart';


// class FirestoreUsersRepository implements UsersRepository<FirestoreUser> {
//   final usersCollection = FirebaseFirestore.instance.collection('exampleSchool');

//   @override
//   Future<void> addNewUser(FirestoreUser user) {
//     return usersCollection.doc(user.id).set((user.toEntity().toDocument()));
//   }

//   @override
//   Future<void> deleteUser(FirestoreUser user) async {
//     return usersCollection.doc(user.id).delete();
//   }

//   @override
//   Stream<List<FirestoreUser>> users() {
//     return usersCollection.snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) => FirestoreUser.fromEntity(UserEntity.fromSnapshot(doc)))
//           .toList();
//     });
//   }

//   @override
//   Future<void> updateUser(FirestoreUser user) {
//     return usersCollection.doc(user.id).update(user.toEntity().toDocument());
//   }

//   @override
//   Future<FirestoreUser> getUserOrDefault(String id) async {
//     try {
//       final potentialUser = await usersCollection.doc(id).get();
//       if (potentialUser.exists) {
//         return FirestoreUser.fromEntity(UserEntity.fromSnapshot(potentialUser));
//       } else {
//         return FirestoreUser.empty;
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }


// }
