import 'package:flutter/material.dart';

import '../../models/word_model.dart';

class WordListTile extends StatefulWidget {
  final WordModel word;
  final Color backgroundColor;

  const WordListTile(this.word, {this.backgroundColor = Colors.white});

  @override
  _WordListTileState createState() => _WordListTileState();
}

class _WordListTileState extends State<WordListTile> {
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
        //TODO: Buraya tıklayınca ne olacağı eklenmeli
      },
    );
  }
}
