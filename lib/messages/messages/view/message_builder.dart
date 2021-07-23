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

class _BuildInputContainer extends StatelessWidget {
  _BuildInputContainer({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  // @override
  // Widget build(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.bottomLeft,
  //     child: Container(
  //       // height: MediaQuery.of(context).size.height * .1,
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       // color: Colors.black,
  //       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //       child: Stack(
  //         children: [
  //           TextFormField(
  //             controller: _controller,
  //           ),
  //           // Align(
  //           //   alignment: Alignment.centerRight,
  //           //   child: Icon(Icons.send),
  //           // ),
  //           Icon(Icons.send),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // height: MediaQuery.of(context).size.height * .1,
      // width: MediaQuery.of(context).size.width * 0.8,
      // color: Colors.black,
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
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Icon(Icons.send),
          // ),
          Container(
              // alignment: Align,
              child: IconButton(
                  onPressed: () {
                    context
                        .read<MessageBloc>()
                        .add(MessageSentText(_controller.text));
                    _controller.clear();
                  },
                  icon: Icon(Icons.send))),
        ],
      ),
    );
  }
}
