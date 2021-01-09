import 'package:flutter/material.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/home_screen/logout_button.dart';

import '../../api/user_api.dart';

class HomeScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HomeScreenAppBarState createState() => _HomeScreenAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  String currentUserFullName = "";

  @override
  Widget build(BuildContext context) {
    UserApi().getCurrentUser().then((currentUser) {
      setState(() {
        currentUserFullName = currentUser.fullname;
      });
    });
    return AppBar(
      title: Row(
        children: [Text(localize(context, 'home_title')), Text(' - $currentUserFullName')],
      ),
      actions: [
        LogoutButton(),
      ],
    );
  }
}
