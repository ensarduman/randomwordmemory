import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/models/word_model.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  List<WordModel> words;

  @override
  Widget build(BuildContext context) {
    var wordApi = WordApi();
    wordApi.getCurrentUserWords().then((wordsResult) {
      setState(() {
        this.words = wordsResult;
      });
    });

    if (words == null) {
      return Container();
    } else {
      return Center(
        child: Text('Random!' + words?.length.toString()),
      );
    }
  }
}
