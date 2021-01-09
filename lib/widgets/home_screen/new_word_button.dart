import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/home_screen/add_or_update_word.dart';

class NewWordButton extends StatefulWidget {
  @override
  _NewWordButtonState createState() => _NewWordButtonState();
}

class _NewWordButtonState extends State<NewWordButton> {
  String targetLanguageContent;
  String myLanguageContent;

  void _saveNewWord() {
    WordApi wordApi = WordApi();

    if (targetLanguageContent == null || targetLanguageContent.trim() == '' || myLanguageContent == null || myLanguageContent.trim() == '') {
      ModalHelper.showToast(localize(context, 'add_or_update_word_save_form_error'));
      return;
    }

    wordApi
        .addOrUpdateWord(
      targetlanguagecontent: targetLanguageContent,
      mylanguagecontent: myLanguageContent,
    )
        .then((id) {
      if (id != null) {
        _closeModal();
      } else {
        ModalHelper.showToast(localize(context, 'add_or_update_word_save_error'));
      }
    });
  }

  void _closeModal() {
    _cleanForm();
    ModalHelper.closeModals(context);
  }

  void _cleanForm() {
    setState(() {
      targetLanguageContent = '';
      myLanguageContent = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModalHelper.showModalDialog(
          context,
          onClose: () {
            _cleanForm();
          },
          title: localize(context, 'add_or_update_word_add_title'),
          content: AddOrUpdateWord(
            onTargetLanguageContentChanged: (value) {
              setState(() {
                targetLanguageContent = value;
              });
            },
            onMyLanguageContentChanged: (value) {
              setState(() {
                myLanguageContent = value;
              });
            },
          ),
          enableFirstButton: true,
          enableSecondButton: true,
          firstButtonText: localize(context, 'add_or_update_word_save_button'),
          secondButtonText: localize(context, 'add_or_update_word_cancel_button'),
          onFirstButtonClick: () {
            _saveNewWord();
          },
          onSecondButtonClick: () {
            _closeModal();
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
            Icons.add,
            size: 50,
            color: Colors.white,
          )),
    );
  }
}
