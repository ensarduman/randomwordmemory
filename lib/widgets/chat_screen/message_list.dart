import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/conversation_api.dart';
import 'package:instantmessage/api/message_api.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/message_model.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/widgets/chat_screen/message_list_tile.dart';
import 'package:instantmessage/widgets/loading_widget.dart';

import '../../api/conversation_api.dart';
import '../../api/message_api.dart';
import 'message_list_tile.dart';
import 'message_list_tile.dart';

class MessageList extends StatefulWidget {
  final UserModel user;

  const MessageList(this.user);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<MessageListTile> messageListTiles;
  @override
  Widget build(BuildContext context) {
    UserApi().getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        ConversationApi().getConversationsByUserIdContains([currentUser.id, widget.user.id]).then((conversations) {
          if (conversations.length > 0) {
            MessageApi().getMessagesByConversationId(conversations.first.id).then((conversationMessages) {
              setState(() {
                messageListTiles = conversationMessages.map((conversationMessage) {
                  return MessageListTile(conversationMessage, currentUser);
                }).toList();
              });
            });
          } else {
            setState(() {
              messageListTiles = List<MessageListTile>();
            });
          }
        });
      }
    });

    if (messageListTiles == null) {
      return LoadingWidget();
    } else {
      return ListView.builder(
        dragStartBehavior: DragStartBehavior.down,
        reverse: true,
        itemCount: messageListTiles.length,
        itemBuilder: (context, index) {
          var messageListTile = messageListTiles[index];
          return messageListTile;
        },
      );
    }
  }
}
