import 'package:flutter/material.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';

class AddOrUpdateWord extends StatefulWidget {
  final String wordId;

  const AddOrUpdateWord({this.wordId});

  @override
  _AddOrUpdateWordState createState() => _AddOrUpdateWordState();
}

class _AddOrUpdateWordState extends State<AddOrUpdateWord> {
  String targetLanguageContent;
  String myLanguageContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextField(
            placeHolder: localize(
              context,
              'add_or_update_word_place_holder_target_language',
            ),
            onChanged: (value) {
              setState(() {
                targetLanguageContent = value;
              });
            },
          ),
          CustomTextField(
            placeHolder: localize(
              context,
              'add_or_update_word_place_holder_my_language',
            ),
            onChanged: (value) {
              setState(() {
                myLanguageContent = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
