import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/widgets/loading_indicator.dart';
import 'package:school_notifier/messages/message.dart';

class ConversationBuilder extends StatelessWidget {
  const ConversationBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        if (state is ConversationInitial) {
          return LoadingIndicator();
        } else if (state is ConversationSuccess &&
            state.conversations.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('you have no conversations'),
          );
        } else if (state is ConversationSuccess) {
          final _conversations = state.conversations;
          // print("conversations $_conversations");
          // print("length of conversations = ${_conversations.length}");
          final _viewerUid =
              context.read<AuthenticationRepository>().currentUser.id;
          return ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              return _buildConversationTile(
                  context, _conversations[index], index, _viewerUid);
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _buildConversationTile(
    context, Conversation conversation, int index, String _viewerUid) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: () {
      // context.read<ConversationBloc>().add(conversation, index);
      Navigator.pushNamed(context, MessagePage.routeName,
          arguments: conversation);
      // context.read<ConversationBloc>().add(conversation, index);
    },
    child: Container(
      color: (conversation.lastMessage.idTo == _viewerUid &&
              !conversation.lastMessage.read)
          ? Colors.white
          : Colors.grey.shade300,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildAvatar(room),
          Expanded(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _getOtherParticipantNames(conversation, _viewerUid),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        _getLastMessage(conversation),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.hintColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatDateString(
                        conversation.lastMessage.timestamp, DateTime.now()),
                    style: theme.textTheme.bodyText1
                        ?.copyWith(color: theme.hintColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _getOtherParticipantNames(Conversation convo, String _viewerUid) {
  final _otherUsers = [
    for (String id in convo.participants)
      if (id != _viewerUid) id
  ];
  var _userNames = [
    for (String userID in _otherUsers) convo.participantsMap![userID]
  ];
  _userNames.sort();
  var res = '${_userNames[0]}';
  for (int i = 1; i < _userNames.length; i++) {
    res += ', ${_userNames[i]}';
  }
  return res;
  // conversation.participantsMap[conversation.participants[0]] == _viewerUid,
}

String _getLastMessage(Conversation convo) {
  return '${convo.participantsMap![convo.lastMessage.idFrom]}: ${convo.lastMessage.content}';
  // conversation.participantsMap[conversation.participants[0]] == _viewerUid,
}
