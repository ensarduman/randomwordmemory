import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/widgets/home_screen/search_user_list_tile.dart';

class SearchUserResults extends StatelessWidget {
  final List<UserModel> users;
  SearchUserResults({this.users});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        dragStartBehavior: DragStartBehavior.down,
        reverse: false,
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          Color backgroundColor;

          if (index % 2 == 0) {
            backgroundColor = StyleColors.homeSearchUserResultListTilePrimaryBackground;
          } else {
            backgroundColor = StyleColors.homeSearchUserResultListTileSecondaryBackground;
          }

          return SearchUserListTile(
            user,
            backgroundColor: backgroundColor,
          );
        },
      ),
    );
  }
}
