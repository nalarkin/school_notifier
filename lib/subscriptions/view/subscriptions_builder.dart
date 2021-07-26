import 'package:authentication_repository/authentication_repository.dart';
import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/profile/profile.dart';
import 'package:school_notifier/subscriptions/subscriptions.dart';
import 'package:school_notifier/widgets/loading_indicator.dart';
import 'package:school_notifier/messages/message.dart';

class SubscriptionBuilder extends StatelessWidget {
  const SubscriptionBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subNames = context.read<ProfileBloc>().state.user.subscriptions;
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if (state is SubscriptionInitial) {
          return LoadingIndicator();
        } else if (state is SubscriptionSuccess &&
            state.subscriptions.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('you have no subscriptions'),
          );
        } else if (state is SubscriptionSuccess) {
          final _subscriptions = state.subscriptions;

          print("subscriptions $_subscriptions");
          print("length of subscriptions = ${_subscriptions.length}");
          final _viewerUid =
              context.read<AuthenticationRepository>().currentUser.id;
          return ListView.builder(
            itemCount: _subscriptions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: _buildSubscriptionTile(
                    context,
                    _subscriptions[index],
                    index,
                    subNames![_subscriptions[index].eventSubscriptionID]),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _buildSubscriptionTile(
    context, FirestoreEvent subscription, int index, String className) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: () {
      // context.read<SubscriptionBloc>().add(subscription, index);
      Navigator.pushNamed(context, MessagePage.routeName,
          arguments: subscription);
      // context.read<SubscriptionBloc>().add(subscription, index);
    },
    child: Container(
      color: Colors.white,
      height: 70,
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildAvatar(room),
          Container(
            // padding: EdgeInsets.all(8),
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.25,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDateEventWeekday(subscription.eventEndTime),
                  style: theme.textTheme.bodyText2
                      ?.copyWith(color: Colors.black, fontSize: 12),
                ),
                if (subscription.eventStartTime != subscription.eventEndTime)
                  Text(
                    formatDateEventStartToEndTime(
                        subscription.eventStartTime, subscription.eventEndTime),
                    style: theme.textTheme.bodyText2
                        ?.copyWith(color: Colors.black, fontSize: 12),
                  ),
                if (subscription.eventStartTime == subscription.eventEndTime)
                  Text(
                    formatDateEventTime(subscription.eventStartTime),
                    style: theme.textTheme.bodyText2
                        ?.copyWith(color: Colors.black, fontSize: 12),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      subscription.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  if (subscription.description.isNotEmpty)
                    Text(
                      subscription.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.black, fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subscription.eventSubscriptionID,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText2
                      ?.copyWith(color: theme.hintColor, fontSize: 8),
                ),
                Text(
                  className,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText2
                      ?.copyWith(color: theme.hintColor),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

// String _getOtherParticipantNames(FirestoreEvent convo, String _viewerUid) {
//   final _otherUsers = [
//     for (String id in convo.participants)
//       if (id != _viewerUid) id
//   ];
//   var _userNames = [
//     for (String userID in _otherUsers) convo.participantsMap![userID]
//   ];
//   _userNames.sort();
//   var res = '${_userNames[0]}';
//   for (int i = 1; i < _userNames.length; i++) {
//     res += ', ${_userNames[i]}';
//   }
//   return res;
//   // subscription.participantsMap[subscription.participants[0]] == _viewerUid,
// }

// String _getLastMessage(FirestoreEvent convo) {
//   return '${convo.participantsMap![convo.lastMessage.idFrom]}: ${convo.lastMessage.content}';
//   // subscription.participantsMap[subscription.participants[0]] == _viewerUid,
// }
