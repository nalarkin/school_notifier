import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users_repository/users_repository.dart';

class FirestoreUserRepository implements UsersRepository<FirestoreUser> {
  final usersCollection = FirebaseFirestore.instance
      .collection('exampleSchool')
      .doc('users')
      .collection('users');

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
          .map((doc) =>
              FirestoreUser.fromEntity(FirestoreUserEntity.fromSnapshot(doc)))
          .toList();
    });
  }
  // List<FirestoreUser> myStudents(List<String> students) {
  //   // return usersCollection.where((event) => false)
  //   final temp = [for (final student in students) usersCollection.doc(student).get()]
  //   return [for (final doc in temp) FirestoreUser.fromEntity(FirestoreUserEntity.fromSnapshot(doc))];
  //   // .map((snapshot) {
  //   //   return snapshot.docs
  //   //       .map((doc) =>
  //   //           FirestoreUser.fromEntity(FirestoreUserEntity.fromSnapshot(doc)))
  //   //       .toList();
  //   // });
  // }

  @override
  Future<void> updateUser(FirestoreUser user) {
    return usersCollection.doc(user.id).update(user.toEntity().toDocument());
  }

  @override
  Future<FirestoreUser> getUserOrDefault(String id) async {
    try {
      final potentialUser = await usersCollection.doc(id).get();
      if (potentialUser.exists) {
        return FirestoreUser.fromEntity(
            FirestoreUserEntity.fromSnapshot(potentialUser));
      } else {
        return FirestoreUser.empty;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<FirestoreUser?> getFirestoreUserIfExists(String id) async {
    final potentialUser = await usersCollection.doc(id).get();
    if (potentialUser.exists) {
      return FirestoreUser.fromEntity(
          FirestoreUserEntity.fromSnapshot(potentialUser));
    }
    return null;
  }


  Future<String?> getFirestoreUserFirstLastName(String id) async {
    final potentialUser = await usersCollection.doc(id).get();
    if (potentialUser.exists) {
      FirestoreUser curr = FirestoreUser.fromEntity(
          FirestoreUserEntity.fromSnapshot(potentialUser));
      return '${curr.firstName} ${curr.lastName}';
    }
    return null;
  }

  Future<Map<String, String>> convertParticipantListToNames(
      List<String> partiticpants) async {
    assert(partiticpants.length >= 0);
    var names = <String, String>{};
    for (String id in partiticpants) {
      final user = await usersCollection.doc(id).get();
      if (user.exists) {
        FirestoreUser curr =
            FirestoreUser.fromEntity(FirestoreUserEntity.fromSnapshot(user));
        names[id] = '${curr.firstName} ${curr.lastName}';
      }
    }
    assert(names.length > 0);
    return names;
  }

  @override
  Stream<FirestoreUser> liveProfileStream(String id) {
    assert(id.isNotEmpty);
    return usersCollection.doc(id).snapshots().map((doc) =>
        FirestoreUser.fromEntity(FirestoreUserEntity.fromSnapshot(doc)));
  }

  /// TODO: Also Create meethod in message repository to update name stored
  /// in conversation
  Future<void> updateFirstLastName(FirestoreUser user) async {
    await usersCollection.doc(user.id).set(<String, String>{
      'firstName': user.firstName ?? '',
      'lastName': user.lastName ?? ''
    }, SetOptions(merge: true));
  }
  // Future<void> addSubscription(FirestoreUser user) async {
  //   await usersCollection.doc(user.id).set(<String, String>{
  //     'firstName': user.firstName ?? '',
  //     'lastName': user.lastName ?? ''
  //   }, SetOptions(merge: true));
  // }
}
