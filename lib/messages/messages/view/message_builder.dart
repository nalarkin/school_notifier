import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:school_notifier/messages/message.dart';
import 'package:school_notifier/profile/profile.dart';
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
        } else if (state.status == MessageStatus.success ||
            state.status == MessageStatus.first) {
          final _messages = state.messages;
          return Stack(children: [
            if (state.status == MessageStatus.first) _EmptyMessagesLabel(),
            CustomScrollView(
              
              slivers: [
              // _MessageList(),
              if (state.status == MessageStatus.success) _MessageList(),
              _SpaceBufforForKeyboard()
              // ListView.builder(
              //   itemCount: _messages.length,
              //   itemBuilder: (context, index) {
              //     return _buildConversationTile(
              //         context, _messages[index], _uid);
              //   },
              // ),
            ]),
            (state.status == MessageStatus.success)
                ? _BuildInputContainer()
                : _BuildNewConversationInputContainer(),
          ]);
        }
        // else if (state.status == MessageStatus.first) {
        //   return Stack(children: [
        //     Container(
        //       alignment: Alignment.center,
        //       child: Text('start a new conversation.'),
        //     ),
        //     _BuildNewConversationInputContainer(),
        //   ]);
        // }
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
      // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
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
                          context.read<MessageBloc>().add(
                              MessageStartFirstConversation(_controller.text));
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
      ),
    );
  }
}

class _SpaceBufforForKeyboard extends StatelessWidget {
  const _SpaceBufforForKeyboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          height: 100,
        );
      },
      childCount: 1,
    ));
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _uid = context.watch<ProfileBloc>().state.user.id;
    final List<Message> messages = context.watch<MessageBloc>().state.messages;
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return _MessageTile(message: messages[index], uid: _uid);
      },
      childCount: messages.length,
    ));
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.message, required this.uid})
      : super(key: key);
  final Message message;
  final String uid;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: message.idFrom == uid
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {},
            child: Bubble(
              child: Text(message.content),
              style: message.idFrom == uid ? styleMe : styleSomebody,
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
}

class _EmptyMessagesLabel extends StatelessWidget {
  const _EmptyMessagesLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      child: Text(
        'no messages',
        style: theme.textTheme.caption,
      ),
    );
  }
}
