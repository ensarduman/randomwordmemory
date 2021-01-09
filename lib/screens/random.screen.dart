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
      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('DSADASD SADHDSUHIAUSDIASD  HDASUD ISAUH IASHD HASD UI ASDISHA IUSHDIUSAHD IUSAHDI ASUDHAS DHIAS DHIAS IUD'),
        ),
      );
    }
  }
}
