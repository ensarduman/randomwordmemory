import 'package:flutter/material.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';

class AddOrUpdateWord extends StatelessWidget {
  final String wordId;
  final String targetLanguageContent;
  final String myLanguageContent;

  final Function(String value) onTargetLanguageContentChanged;
  final Function(String value) onMyLanguageContentChanged;

  const AddOrUpdateWord({this.wordId, this.targetLanguageContent, this.myLanguageContent, this.onTargetLanguageContentChanged, this.onMyLanguageContentChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextField(
            controller: TextEditingController(text: targetLanguageContent ?? ''),
            placeHolder: localize(
              context,
              'add_or_update_word_place_holder_target_language',
            ),
            onChanged: (value) {
              if (onTargetLanguageContentChanged != null) {
                onTargetLanguageContentChanged(value);
              }
            },
          ),
          CustomTextField(
            controller: TextEditingController(text: myLanguageContent ?? ''),
            placeHolder: localize(
              context,
              'add_or_update_word_place_holder_my_language',
            ),
            onChanged: (value) {
              if (onMyLanguageContentChanged != null) {
                onMyLanguageContentChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
