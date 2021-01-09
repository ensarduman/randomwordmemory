import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/models/word_model.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/widgets/home_screen/word_list_tile.dart';
import 'package:instantmessage/widgets/loading_widget.dart';

class WordList extends StatelessWidget {
  final List<WordModel> words;

  const WordList({@required this.words});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<WordListTile> wordTiles;
    if (words != null) {
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
    }

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
