import 'package:flutter/material.dart';
import 'package:instantmessage/widgets/home_screen/logout_button.dart';

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userFullName;

  const ChatScreenAppBar(this.userFullName);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(userFullName),
      actions: [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
