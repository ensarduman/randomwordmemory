import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalBottomButtons extends StatelessWidget {
  final bool isRightButtonDisabled;
  final bool isLeftButtonDisabled;
  final Function onLeftClick;
  final Function onRightClick;
  final String leftButtonText;
  final String rightButtonText;

  const ModalBottomButtons({Key key, this.isLeftButtonDisabled = false, this.isRightButtonDisabled = false, this.onLeftClick, this.onRightClick, @required this.leftButtonText, @required this.rightButtonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CupertinoButton(
            child: Text(
              // localize(context, 'Cancel'),
              this.leftButtonText,
              style: isLeftButtonDisabled
                  ? TextStyle(
                      color: const Color(0xffa1a1a1),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0,
                    )
                  : TextStyle(
                      color: Colors.blue[500],
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0,
                    ),
            ),
            onPressed: () {
              if (this.onLeftClick != null) {
                this.onLeftClick();
              }
            },
          ),
          Expanded(
            child: Container(),
          ),
          CupertinoButton(
            child: Text(
              // localize(context, 'Save'),
              this.rightButtonText,
              style: isRightButtonDisabled
                  ? TextStyle(
                      color: const Color(0xffa1a1a1),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0,
                    )
                  : TextStyle(
                      color: Colors.blue[500],
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0,
                    ),
            ),
            onPressed: () {
              if (this.onRightClick != null && !isRightButtonDisabled) {
                this.onRightClick();
              }
            },
          )
        ],
      ),
    );
  }
}
