import 'package:flutter/material.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModalHelper.showBottomModal(context, content: Text('ASDSADASDASD'));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              )),
          child: Icon(
            Icons.play_arrow,
            size: 50,
            color: Colors.white,
          )),
    );
  }
}
