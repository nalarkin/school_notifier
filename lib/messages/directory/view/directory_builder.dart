import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/widgets/widgets.dart';
import 'package:users_repository/users_repository.dart';

import '../directory.dart';

class DirectoryBuilder extends StatelessWidget {
  const DirectoryBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String _uid = context.watch<AuthenticationRepository>().currentUser.id;
    FirestoreUser _currUser = context.watch<ProfileBloc>().state.user;
    return BlocBuilder<DirectoryBloc, DirectoryState>(
      builder: (context, state) {
        if (state.status == DirectoryStatus.initial) {
          return LoadingIndicator();
        } else if (state.status == DirectoryStatus.success) {
          final _users = state.users;
          return Stack(
            children: [
              ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return _BuildUserTile(context, _users[index], _currUser);
                },
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: const Color(0xFFFFD600),
                      ),
                      child: Text(
                        'Your Students.',
                        style: theme.textTheme.button,
                      ),
                      onPressed: () => context
                          .read<DirectoryBloc>()
                          .add(DirectorySelectFiltered()),
                    ),
                  )),
            ],
          );
        } else if (state.status == DirectoryStatus.filter) {
          final _users = state.filteredUsers;
          return Stack(
            children: [
              ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return _BuildUserTile(context, _users[index], _currUser);
                },
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: const Color(0xFFFFD600),
                      ),
                      child: Text(
                        'All Users.',
                        style: theme.textTheme.button,
                      ),
                      onPressed: () => context
                          .read<DirectoryBloc>()
                          .add(DirectorySelectAllUsers()),
                    ),
                  )),
            ],
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _BuildUserTile(
    context, FirestoreUser user, FirestoreUser _currUser) {
  final theme = Theme.of(context);
  return GestureDetector(
      onTap: () {
        // debugDumpApp();
        print(_currUser);
        Message blankMessage = Message(
            id: 'dummyid',
            conversationId: Message.getConvoID(_currUser.id, user.id),
            content: 'dummy content',
            idFrom: _currUser.id,
            idTo: user.id,
            timestamp: DateTime.now());
        Conversation newConvo = Conversation(
            id: Message.getConvoID(_currUser.id, user.id),
            participants: [_currUser.id, user.id],
            participantsMap: {
              _currUser.id:
                  '${_currUser.firstName} ${_currUser.lastName ?? ''}',
              user.id: '${user.firstName} ${user.lastName ?? ''}',
            },
            lastMessage: blankMessage);

        Navigator.pushNamed(context, MessagePage.routeName,
            arguments: newConvo);
      },
      child: Container(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
              // border: Border.all(color: theme.accentColor),
              color: theme.canvasColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ListTile(
            title: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    // Text(
                    //   '${userRoleToString(user.role)!.toUpperCase()}',
                    //   style: theme.textTheme.caption
                    //       ?.copyWith(color: Colors.grey, fontSize: 10),
                    // ),
                    if (user.role == UserRole.teacher) Icon(Icons.school),
                    if (user.role == UserRole.student)
                      Icon(Icons.child_care_sharp),
                    if (user.role == UserRole.parent) Icon(Icons.person),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                Text(
                  '${user.firstName} ${user.lastName ?? ''}',
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
}

// class _BuildUserTile extends StatelessWidget {
//   const _BuildUserTile({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // debugDumpApp();
//         FirestoreUser _currUser = context.r
//         print(_currUser);
//         // Message blankMessage = Message(
//         //     content: '',
//         //     idFrom: _uid,
//         //     idTo: user.id,
//         //     timestamp: DateTime.now());
//         // Conversation newConvo = Conversation(
//         //     id: Message.getConvoID(_uid, user.id),
//         //     participants: [_uid, user.id],
//         //     participantsMap: {
//         //       _uid: '${_currUser.firstName} ${_currUser.lastName}',
//         //       user.id: '${user.firstName} ${user.lastName}',
//         //     },
//         //     lastMessage: blankMessage);

//         // Navigator.pushNamed(context, MessagePage.routeName,
//         //     arguments: newConvo);
//       },
//       child: Card(
//         child: ListTile(
//           title: Stack(
//             alignment: Alignment.center,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     '${userRoleToString(user.role)!.toUpperCase()}',
//                     style:
//                         theme.textTheme.caption?.copyWith(color: Colors.black),
//                   ),
//                   Expanded(
//                     child: Container(),
//                   ),
//                 ],
//               ),
//               Text(
//                 '${user.firstName} ${user.lastName}',
//                 style: theme.textTheme.headline6?.copyWith(color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//       ));
//   }
// }