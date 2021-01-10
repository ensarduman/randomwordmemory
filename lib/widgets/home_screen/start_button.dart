import 'package:flutter/material.dart';
import 'package:instantmessage/common/enums.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/routes/route_names.dart';

class StartButton extends StatelessWidget {
  const StartButton();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModalHelper.showModalDialog(
          context,
          content: DropdownButton(
            hint: Text(localize(context, 'EnumDateFilterType_hint')),
            items: EnumDateFilterType.values.map((value) {
              return DropdownMenuItem(
                child: Text(localize(context, value.toString())),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              ModalHelper.closeModals(context);
              Navigator.of(context).pushNamed(RouteNames.random, arguments: value);
            },
          ),
        );
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
