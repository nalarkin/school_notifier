import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/widgets/loading_indicator.dart';
import 'package:bubble/bubble.dart';

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _uid = context.watch<AuthenticationRepository>().currentUser.id;
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state.status == MessageStatus.initial) {
          return LoadingIndicator();
        } else if (state.status == MessageStatus.success) {
          final _messages = state.messages;
          return ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _buildConversationTile(context, _messages[index], _uid);
            },
          );
        }
        return Container();
      },
    );
  }
}

GestureDetector _buildConversationTile(context, Message message, String _uid) {
  final theme = Theme.of(context);
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
      child: Bubble(
        child: Text(message.content),
        style: message.idFrom == _uid ? styleMe : styleSomebody,
      ));
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

const styleSomebody = BubbleStyle(
  nip: BubbleNip.leftTop,
  color: Colors.white,
  borderColor: Colors.blue,
  borderWidth: 1,
  elevation: 1,
  margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topLeft,
);

const styleMe = BubbleStyle(
  nip: BubbleNip.rightBottom,
  color: Color.fromARGB(255, 225, 255, 199),
  borderColor: Colors.blue,
  borderWidth: 1,
  elevation: 1,
  margin: BubbleEdges.only(top: 8, left: 50),
  alignment: Alignment.topRight,
);
