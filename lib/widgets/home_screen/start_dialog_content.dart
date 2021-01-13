import 'package:flutter/material.dart';
import 'package:instantmessage/common/enums.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/models/random_screen_model.dart';
import 'package:instantmessage/routes/route_names.dart';

class StartDialogContent extends StatefulWidget {
  @override
  _StartDialogContentState createState() => _StartDialogContentState();
}

class _StartDialogContentState extends State<StartDialogContent> {
  EnumDateFilterType dataFilterType = EnumDateFilterType.All;
  bool isMyLanguageFirst = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isMyLanguageFirst,
                onChanged: (value) {
                  setState(() {
                    isMyLanguageFirst = value;
                  });
                },
              ),
              Text(localize(context, 'start_dialog_content_isMyLanguageFirst'))
            ],
          ),
          DropdownButton(
            value: dataFilterType,
            hint: Text(localize(context, 'EnumDateFilterType_hint')),
            items: EnumDateFilterType.values.map((value) {
              return DropdownMenuItem(
                child: Text(localize(context, value.toString())),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dataFilterType = value;
              });
            },
          ),
          RaisedButton(
            child: Text(localize(context, 'start_dialog_content_start')),
            onPressed: () {
              ModalHelper.closeModals(context);
              RandomScreenModel randomScreenModel = RandomScreenModel(dataFilterType: dataFilterType, isMyLanguageFirst: isMyLanguageFirst);
              Navigator.of(context).pushNamed(RouteNames.random, arguments: randomScreenModel);
            },
          ),
        ],
      ),
    );
  }
}
