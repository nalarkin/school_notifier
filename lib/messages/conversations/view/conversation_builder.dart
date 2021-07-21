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
          return ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              return _buildConversationTile(_conversations[index]);
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _buildConversationTile(Conversation conversation) {
  return GestureDetector(
    onTap: () {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => ChatPage(
      //       room: room,
      //     ),
      //   ),
      // );
    },
    child: Container(
      // clipBehavior: Clip.hardEdge,
      // decoration: BoxDecoration(),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildAvatar(room),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(conversation.lastMessage.idFrom),
                Text(
                  conversation.lastMessage.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
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
  if (difference > Duration(days: 7)) {
    return '${date.day}/${date.month}';
  } else if (difference >= Duration(days: 1)) {
    return '${weekdays[date.day]}';
  }

  return '${date.hour}:${date.minute}';
}
