import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/word_api.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/widgets/home_screen/word_list_tile.dart';
import 'package:instantmessage/widgets/loading_widget.dart';

class WordList extends StatefulWidget {
  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  List<WordListTile> wordTiles;

  @override
  Widget build(BuildContext context) {
    var wordApi = WordApi();

    UserApi().getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        wordApi.getCurrentUserWords().then((words) {
          setState(() {
            int index = 0;
            wordTiles = words.map((word) {
              Color backgroundColor;
              index++;
              if (index % 2 == 0) {
                backgroundColor = StyleColors.homeWordTilePrimaryBackground;
              } else {
                backgroundColor = StyleColors.homeWordTileSecondaryBackground;
              }

              return WordListTile(
                word,
                backgroundColor: backgroundColor,
              );
            }).toList();
          });
        });
      }
    });

    if (wordTiles == null) {
      return LoadingWidget();
    } else {
      return ListView.builder(
        dragStartBehavior: DragStartBehavior.down,
        reverse: false,
        itemCount: wordTiles.length,
        itemBuilder: (context, index) {
          var wordTile = wordTiles[index];
          return wordTile;
        },
      );
    }
  }
}
