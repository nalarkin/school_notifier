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
          return Stack(
            children: [
              ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildConversationTile(
                      context, _messages[index], _uid);
                },
              ),
              _BuildInputContainer(),
            ],
          );
        } else if (state.status == MessageStatus.first) {
          return Stack(children: [
            Container(
              alignment: Alignment.center,
              child: Text('start a new conversation.'),
            ),
            _BuildNewConversationInputContainer(),
          ]);
        }
        return Container();
      },
    );
  }
}

Column _buildConversationTile(context, Message message, String _uid) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: message.idFrom == _uid
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
    children: [
      GestureDetector(
          onTap: () {},
          child: Bubble(
            child: Text(message.content),
            style: message.idFrom == _uid ? styleMe : styleSomebody,
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          formatDateString(message.timestamp, DateTime.now()),
          style: theme.textTheme.subtitle1
              ?.copyWith(color: Colors.grey, fontSize: 10),
          // textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

// // String _formatDateString(DateTime date, DateTime currentDate) {
//   const weekdays = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
//   final difference = currentDate.difference(date);
//   if (difference > Duration(days: 7)) {
//     return '${date.day}/${date.month}';
//   } else if (difference >= Duration(days: 1)) {
//     return '${weekdays[date.weekday]}';
//   }

//   return '${date.hour}:${date.minute}';
// }

class _BuildInputContainer extends StatelessWidget {
  _BuildInputContainer({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(child: Container()),
        Container(
          alignment: Alignment.bottomCenter,
          // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          color: theme.canvasColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  color: theme.canvasColor,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextField(
                    controller: _controller,
                  ),
                ),
              ),
              Container(
                  child: IconButton(
                      onPressed: () {
                        if (_controller.text.trim().isEmpty) return null;
                        context
                            .read<MessageBloc>()
                            .add(MessageSentText(_controller.text));
                        _controller.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        size: 30,
                        color: theme.accentColor,
                      ))),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildNewConversationInputContainer extends StatelessWidget {
  _BuildNewConversationInputContainer({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: _controller,
            ),
          ),
          Container(
              child: IconButton(
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return null;
                    context
                        .read<MessageBloc>()
                        .add(MessageStartFirstConversation(_controller.text));
                    _controller.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    size: 30,
                    color: theme.accentColor,
                  ))),
        ],
      ),
    );
  }
}
