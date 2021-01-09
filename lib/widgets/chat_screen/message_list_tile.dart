import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/models/message_model.dart';
import 'package:instantmessage/models/user_model.dart';

import '../../models/user_model.dart';

class MessageListTile extends StatefulWidget {
  final MessageModel message;
  final UserModel currentUser;

  MessageListTile(this.message, this.currentUser);

  @override
  _MessageListTileState createState() => _MessageListTileState();
}

class _MessageListTileState extends State<MessageListTile> {
  @override
  Widget build(BuildContext context) {
    var side = widget.message.fromuserid != widget.currentUser.id;

    var backgroundColor = side ? StyleColors.chatMessageBoxSent : StyleColors.chatMessageBoxReceived;

    return Container(
      alignment: side ? Alignment.centerLeft : Alignment.centerRight,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // border: Border.all(),
          color: backgroundColor,
        ),
        child: Text(widget.message.contenttext),
      ),
    );
  }
}
