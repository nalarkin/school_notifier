import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_notifier/widgets/widgets.dart';
import 'package:users_repository/users_repository.dart';

import '../directory.dart';

class DirectoryBuilder extends StatelessWidget {
  const DirectoryBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _uid = context.watch<AuthenticationRepository>().currentUser.id;
    return BlocBuilder<DirectoryBloc, DirectoryState>(
      builder: (context, state) {
        if (state.status == DirectoryStatus.initial) {
          return LoadingIndicator();
        } else if (state.status == DirectoryStatus.success) {
          final _users = state.users;
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return _BuildUserTile(context, _users[index], _uid);
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _BuildUserTile(context, FirestoreUser user, String _uid) {
  final theme = Theme.of(context);
  return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          title: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisAlignment.spaceEvenly,
            alignment: Alignment.center,

            children: [
              Row(
                children: [
                  Text(
                    '${userRoleToString(user.role)!.toUpperCase()}',
                    style:
                        theme.textTheme.caption?.copyWith(color: Colors.black),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Text(
                '${user.firstName} ${user.lastName}',
                style: theme.textTheme.headline6?.copyWith(color: Colors.black),
              ),
              // IntrinsicWidth()
            ],
          ),
          // leading: Text(
          //   '${userRoleToString(user.role)!.toUpperCase()}',
          //   style: theme.textTheme.caption?.copyWith(color: Colors.black),
          // ),
        ),
      ));
}
