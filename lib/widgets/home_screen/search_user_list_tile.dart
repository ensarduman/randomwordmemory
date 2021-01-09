import 'package:flutter/material.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/routes/route_names.dart';

class SearchUserListTile extends StatefulWidget {
  final UserModel user;
  final Color backgroundColor;

  const SearchUserListTile(this.user, {this.backgroundColor = Colors.white});

  @override
  _SearchUserListTileState createState() => _SearchUserListTileState();
}

class _SearchUserListTileState extends State<SearchUserListTile> {
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
                  Text(widget.user.fullname),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        ModalHelper.closeModals(context);
        Navigator.of(context).pushNamed(RouteNames.chat, arguments: widget.user);
      },
    );
  }
}
