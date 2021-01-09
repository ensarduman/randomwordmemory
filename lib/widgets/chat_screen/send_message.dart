import 'package:flutter/material.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';

import '../../api/message_api.dart';
import '../../common/helpers/modal_helper.dart';

class SendMessage extends StatefulWidget {
  final String toUserId;

  const SendMessage(this.toUserId);
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  var controller = TextEditingController();
  String messageText = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: CustomTextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  messageText = value;
                });
              },
              placeHolder: localize(context, 'chat_write_message'),
            ),
          ),
          InkWell(
              onTap: () {
                if (messageText != null && messageText.trim() != '') {
                  MessageApi().sendMessage(widget.toUserId, messageText);
                  controller.clear();
                  setState(() {
                    messageText = '';
                  });
                }
              },
              child: Icon(Icons.send))
        ],
      ),
    );
  }
}
