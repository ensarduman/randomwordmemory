import 'package:flutter/material.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/home_screen/add_or_update_word.dart';

class NewWordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModalHelper.showModalDialog(
          context,
          title: localize(context, 'add_or_update_word_add_title'),
          content: AddOrUpdateWord(),
          enableFirstButton: true,
          enableSecondButton: true,
          firstButtonText: localize(context, 'add_or_update_word_save_button'),
          secondButtonText: localize(context, 'add_or_update_word_cancel_button'),
          onFirstButtonClick: () {},
          onSecondButtonClick: () {
            ModalHelper.closeModals(context);
          },
        );
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
