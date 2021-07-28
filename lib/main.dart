import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:school_notifier/app/app.dart';
import 'package:users_repository/users_repository.dart';
import 'package:flutter/rendering.dart';
import 'notification/notification_service.dart';

void main() async {
  debugRepaintRainbowEnabled = true;
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  // final postsRepository = FirestorePostsRepository();
  await authenticationRepository.user.first;
  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}
