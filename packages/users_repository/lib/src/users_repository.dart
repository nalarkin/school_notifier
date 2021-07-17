import 'dart:async';

import 'package:users_repository/users_repository.dart';

abstract class UsersRepository<T> {
  Future<void> addNewUser(T user);

  Future<void> deleteUser(T user);

  Stream<List<T>> users();

  Future<void> updateUser(T user);

  Future<T> getUserOrDefault(String id);

  Stream<T> liveProfileStream(String id);
}
