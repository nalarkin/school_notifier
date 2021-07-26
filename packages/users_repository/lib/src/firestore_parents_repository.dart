// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:users_repository/users_repository.dart';

// class FirestoreParentsRepository implements UsersRepository<Parent> {
//   final parentsCollection = FirebaseFirestore.instance
//       .collection('exampleSchool')
//       .doc('parents')
//       .collection('parents');

//   @override
//   Future<void> addNewUser(Parent user) {
//     return parentsCollection.doc(user.id).set((user.toEntity().toDocument()));
//   }

//   @override
//   Future<void> deleteUser(Parent user) async {
//     return parentsCollection.doc(user.id).delete();
//   }

//   @override
//   Stream<List<Parent>> users() {
//     return parentsCollection.snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) => Parent.fromEntity(ParentEntity.fromSnapshot(doc)))
//           .toList();
//     });
//   }

//   @override
//   Future<void> updateUser(Parent user) {
//     return parentsCollection.doc(user.id).update(user.toEntity().toDocument());
//   }

//   @override
//   Future<Parent> getUserOrDefault(String id) async {
//     try {
//       final potentialUser = await parentsCollection.doc(id).get();
//       if (potentialUser.exists) {
//         return Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
//       } else {
//         return Parent.empty;
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   Future<Parent?> getParentIfExists(String id) async {
//     final potentialUser = await parentsCollection.doc(id).get();
//     if (potentialUser.exists) {
//       return Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
//     }
//     return null;
//   }

//   Future<String?> getParentFirstLastName(String id) async {
//     final potentialUser = await parentsCollection.doc(id).get();
//     if (potentialUser.exists) {
//       Parent curr = Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
//       return '${curr.firstName} ${curr.lastName}';
//     }
//     return null;
//   }

//   Future<Map<String, String>> convertParticipantListToNames(
//       List<String> partiticpants) async {
//     assert(partiticpants.length >= 0);
//     var names = <String, String>{};
//     for (String id in partiticpants) {
//       final user = await parentsCollection.doc(id).get();
//       if (user.exists) {
//         Parent curr = Parent.fromEntity(ParentEntity.fromSnapshot(user));
//         names[id] = '${curr.firstName} ${curr.lastName}';
//       }
//     }
//     assert(names.length > 0);
//     return names;
//   }
//   // Future<String> getParentFirstLastName(String id) async {
//   //   final potentialUser = await parentsCollection.doc(id).get();
//   //   if (potentialUser.exists) {
//   //     Parent curr = Parent.fromEntity(ParentEntity.fromSnapshot(potentialUser));
//   //     return '${curr.firstName} ${curr.lastName}';
//   //   }
//   //   return '';
//   // }

//   @override
//   Stream<Parent> liveProfileStream(String id) {
//     return parentsCollection
//         .doc(id)
//         .snapshots()
//         .map((doc) => Parent.fromEntity(ParentEntity.fromSnapshot(doc)));
//   }
// }
