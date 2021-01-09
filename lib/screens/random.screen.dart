import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/models/word_model.dart';
import 'package:instantmessage/widgets/random_screen/next_word_button.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  List<WordModel> words;
  int wordIndex;

  void _setNewIndex() {
    setState(() {
      wordIndex = Random().nextInt(words.length);
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
        _setNewIndex();
      }

      var selectedWord = this.words[wordIndex];
      this.words.removeAt(wordIndex);

      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text(selectedWord.targetlanguagecontent),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: NextButton(
                onTap: () {
                  if (words.length > 0) {
                    _setNewIndex();
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
