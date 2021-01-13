import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/common/enums.dart';
import 'package:instantmessage/models/random_screen_model.dart';
import 'package:instantmessage/models/word_model.dart';
import 'package:instantmessage/widgets/random_screen/exit_random_button.dart';
import 'package:instantmessage/widgets/random_screen/next_word_button.dart';

class RandomScreen extends StatefulWidget {
  final RandomScreenModel randomScreenModel;

  const RandomScreen({this.randomScreenModel});

  @override
  _RandomScreenState createState() => _RandomScreenState(this.randomScreenModel);
}

class _RandomScreenState extends State<RandomScreen> {
  final RandomScreenModel randomScreenModel;
  _RandomScreenState(this.randomScreenModel) {
    enumWordSide = randomScreenModel.isMyLanguageFirst ? EnumWordSide.MyLanguage : EnumWordSide.TargetLanguage;
  }

  List<WordModel> words;
  int wordIndex;
  EnumWordSide enumWordSide;
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

  void _refreshState() {
    setState(() {
      words = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var wordApi = WordApi();

    if (words == null) {
      wordApi.getCurrentUserWords(dateFilter: widget.randomScreenModel.dataFilterType).then((wordsResult) {
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
        backgroundColor: enumWordSide == EnumWordSide.TargetLanguage ? Colors.red : Colors.white,
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text(
                enumWordSide == EnumWordSide.TargetLanguage ? selectedWord.targetlanguagecontent : selectedWord.mylanguagecontent,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: ExitRandomButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NextWordButton(
                onTap: () {
                  setState(() {
                    this.enumWordSide = widget.randomScreenModel.isMyLanguageFirst ? EnumWordSide.MyLanguage : EnumWordSide.TargetLanguage;
                  });

                  if (words.length > 0) {
                    _setSelectedWord();
                  } else {
                    _refreshState();
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
