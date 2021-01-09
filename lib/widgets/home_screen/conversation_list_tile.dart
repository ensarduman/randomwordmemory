import 'package:flutter/material.dart';
import 'package:instantmessage/routes/route_names.dart';

import '../../models/conversation_model.dart';
import '../../models/user_model.dart';

class ConversationListTile extends StatefulWidget {
  final UserModel user;
  final ConversationModel conversation;
  final Color backgroundColor;

  const ConversationListTile(this.conversation, this.user, {this.backgroundColor = Colors.white});

  @override
  _ConversationListTileState createState() => _ConversationListTileState();
}

class _ConversationListTileState extends State<ConversationListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(widget.user.fullname ?? ''),
                  Text(widget.conversation.lastmessagecontenttext ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.chat, arguments: widget.user);
      },
    );
  }
}
