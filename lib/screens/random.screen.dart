import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/models/word_model.dart';
import 'package:instantmessage/widgets/random_screen/next_word_button.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

enum EnumWordSide {
  TargetLanguage,
  MyLanguage,
}

class _RandomScreenState extends State<RandomScreen> {
  List<WordModel> words;
  int wordIndex;
  EnumWordSide enumWordSide = EnumWordSide.TargetLanguage;
  WordModel selectedWord;

  void _setNewIndex() {
    setState(() {
      if (this.words != null && this.words.length != 0) {
        wordIndex = Random().nextInt(words.length);
      }
    });
  }

  void _setSelectedWord() {
    _setNewIndex();
    setState(() {
      if (this.words != null) {
        selectedWord = this.words[wordIndex];
        this.words.removeAt(wordIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var wordApi = WordApi();

    if (words == null) {
      wordApi.getCurrentUserWords().then((wordsResult) {
        setState(() {
          this.words = wordsResult;
        });
      });

      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('Loading...'),
        ),
      );
    } else {
      if (wordIndex == null) {
        _setSelectedWord();
      }

      return Scaffold(
        backgroundColor: Colors.red,
        body: InkWell(
          onTap: () {
            setState(() {
              if (enumWordSide == EnumWordSide.TargetLanguage) {
                enumWordSide = EnumWordSide.MyLanguage;
              } else {
                enumWordSide = EnumWordSide.TargetLanguage;
              }
            });
          },
          child: Center(
            child: Text(enumWordSide == EnumWordSide.TargetLanguage ? selectedWord.targetlanguagecontent : selectedWord.mylanguagecontent),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: NextButton(
                onTap: () {
                  setState(() {
                    this.enumWordSide = EnumWordSide.TargetLanguage;
                  });

                  if (words.length > 0) {
                    _setSelectedWord();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
