import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/widgets/loading_indicator.dart';

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
          print("conversations $_conversations");
          print("length of conversations = ${_conversations.length}");
          return ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              return _buildConversationTile(
                  context, _conversations[index], index);
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _buildConversationTile(
    context, Conversation conversation, int index) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: () {
      // context.read<ConversationBloc>().add(conversation, index);
      Navigator.pushNamed(context, MessagePage.routeName,
          arguments: conversation);
      // context.read<ConversationBloc>().add(conversation, index);
    },
    child: Container(
      color:
          conversation.lastMessage.read ? Colors.grey.shade300 : Colors.white,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildAvatar(room),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  conversation.lastMessage.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.bodyText1?.copyWith(color: Colors.black),
                ),
                Text(
                  '${conversation.lastMessage.idFrom}: ${conversation.lastMessage.content}',
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
            child: Text(_formatDateString(
                conversation.lastMessage.timestamp, DateTime.now())),
          )
        ],
      ),
    ),
  );
}

String _formatDateString(DateTime date, DateTime currentDate) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  final difference = currentDate.difference(date);
  print(difference.inDays);
  if (difference >= Duration(days: 7)) {
    return '${date.day}/${date.month}';
  } else if (difference >= Duration(days: 1)) {
    return '${weekdays[date.weekday - 1]}';
  }

  return '${date.hour}:${date.minute}';
}
