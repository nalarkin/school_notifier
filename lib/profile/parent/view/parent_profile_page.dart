import 'package:flutter/material.dart';
import 'package:school_notifier/authentication/authentication.dart';
// import 'package:school_notifier/home/home.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:users_repository/users_repository.dart';
import '../../profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/widgets.dart';

class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({Key? key}) : super(key: key);
  static const String routeName = '/parent_profile_page';

  @override
  Widget build(BuildContext context) {
    Parent currentParent =
        context.watch<NavigationBloc>().state.parent ?? Parent.empty;
    return BlocProvider(
      create: (_) => ParentProfileBloc(
          parentsRepository: context.read<FirestoreParentsRepository>(),
          parentId: currentParent.id),
      child: ProfileLoader(),
    );
  }
}

class ProfileLoader extends StatelessWidget {
  const ProfileLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentProfileBloc, ParentProfileState>(
      builder: (context, state) {
        if (state is ParentProfileInitial) {
          return LoadingIndicator();
        } else if (state is ParentProfileSuccess) {
          return ProfileView();
        }

        throw Exception(
            'This case should never occur. located in profile_page.dart');
      },
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: <Widget>[
            IconButton(
              key: const Key('profilePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
            )
          ],
        ),
        body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Avatar(),
                SizedBox(
                  height: 8.0,
                ),
                _FirstNameDisplay()
              ],
            ),
          ),
        ));
  }
}

class _FirstNameDisplay extends StatelessWidget {
  const _FirstNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentProfileBloc, ParentProfileState>(
        buildWhen: (previous, current) =>
            previous.parent.firstName != current.parent.firstName,
        builder: (context, state) {
          return Container(
            color: Colors.red,
            child: Text(state.parent.firstName ?? ''),
          );
        });
  }
}
