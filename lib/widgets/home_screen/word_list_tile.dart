import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/home_screen/add_or_update_word.dart';

import '../../models/word_model.dart';

class WordListTile extends StatefulWidget {
  final WordModel word;
  final Color backgroundColor;

  const WordListTile(this.word, {this.backgroundColor = Colors.white});

  @override
  _WordListTileState createState() => _WordListTileState();
}

class _WordListTileState extends State<WordListTile> {
  String targetLanguageContent;
  String mylanguagecontent;

  void _saveNewWord() {
    WordApi wordApi = WordApi();

    if (targetLanguageContent == null || targetLanguageContent.trim() == '' || mylanguagecontent == null || mylanguagecontent.trim() == '') {
      ModalHelper.showToast(localize(context, 'add_or_update_word_save_form_error'));
      return;
    }

    wordApi
        .addOrUpdateWord(
      wordId: widget.word.id,
      targetlanguagecontent: targetLanguageContent,
      mylanguagecontent: mylanguagecontent,
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
      mylanguagecontent = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(widget.word.targetlanguagecontent ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          targetLanguageContent = widget.word.targetlanguagecontent;
          mylanguagecontent = widget.word.mylanguagecontent;
        });

        ModalHelper.showModalDialog(
          context,
          onClose: () {
            _cleanForm();
          },
          title: localize(context, 'add_or_update_word_update_title'),
          content: AddOrUpdateWord(
            targetLanguageContent: widget.word.targetlanguagecontent,
            mylanguagecontent: widget.word.mylanguagecontent,
            onTargetLanguageContentChanged: (value) {
              setState(() {
                targetLanguageContent = value;
              });
            },
            onMyLanguageContentChanged: (value) {
              setState(() {
                mylanguagecontent = value;
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
    );
  }
}
