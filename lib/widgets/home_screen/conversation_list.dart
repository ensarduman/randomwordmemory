import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/conversation_api.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/widgets/home_screen/conversation_list_tile.dart';
import 'package:instantmessage/models/conversation_model.dart';
import 'package:instantmessage/widgets/loading_widget.dart';

import '../../models/user_model.dart';
import '../../models/user_model.dart';

class ConversationList extends StatefulWidget {
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  List<ConversationListTile> conversationTiles;

  String _getFromUserId(ConversationModel conversation, UserModel currentUser) {
    var ids = conversation.userids.where((element) => element != currentUser.id).toList();
    if (ids.length == 0) {
      return currentUser.id;
    } else {
      return ids.first;
    }
  }

  List<String> _getFromUserIds(List<ConversationModel> conversations, UserModel currentUser) {
    var fromUserIds = conversations.map((conversation) {
      return _getFromUserId(conversation, currentUser);
    }).toList();

    return fromUserIds;
  }

  @override
  Widget build(BuildContext context) {
    var conversationApi = ConversationApi();

    UserApi().getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        conversationApi.getCurrentUserConversations().then((conversations) {
          setState(() {
            int index = 0;
            // conversationTiles = List<ConversationListTile>();
            var fromUserIds = _getFromUserIds(conversations, currentUser);

            var userApi = UserApi();
            userApi.getUsersByUserIds(fromUserIds).then((fromUsers) {
              conversationTiles = conversations.map((conversation) {
                var fromUser = fromUsers.firstWhere((user) => _getFromUserId(conversation, currentUser) == user.id);
                Color backgroundColor;
                index++;
                if (index % 2 == 0) {
                  backgroundColor = StyleColors.homeConversationTilePrimaryBackground;
                } else {
                  backgroundColor = StyleColors.homeConversationTileSecondaryBackground;
                }

                return ConversationListTile(
                  conversation,
                  fromUser,
                  backgroundColor: backgroundColor,
                );
              }).toList();
            });
          });
        });
      }
    });

    if (conversationTiles == null) {
      return LoadingWidget();
    } else {
      return ListView.builder(
        dragStartBehavior: DragStartBehavior.down,
        reverse: false,
        itemCount: conversationTiles.length,
        itemBuilder: (context, index) {
          var conversationTile = conversationTiles[index];
          return conversationTile;
        },
      );
    }
  }
}
