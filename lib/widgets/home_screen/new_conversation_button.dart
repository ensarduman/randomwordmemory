import 'package:flutter/material.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/widgets/home_screen/search_user.dart';

class NewConversationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModalHelper.showBottomModal(context, content: SearchUser());
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              )),
          child: Icon(
            Icons.create,
            size: 50,
            color: Colors.white,
          )),
    );
  }
}