import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/conversation_api.dart';
import 'package:instantmessage/api/message_api.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/message_model.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/widgets/chat_screen/chat_screen_app_bar.dart';
import 'package:instantmessage/widgets/chat_screen/message_list.dart';
import 'package:instantmessage/widgets/chat_screen/send_message.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;

  const ChatScreen(this.user);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    messages = List<MessageModel>();

    return Scaffold(
      appBar: ChatScreenAppBar(widget.user.fullname),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessageList(widget.user)),
            SendMessage(widget.user.id),
          ],
        ),
      ),
    );
  }
}
