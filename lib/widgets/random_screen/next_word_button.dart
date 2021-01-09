import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Function onTap;
  const NextButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              )),
          child: Icon(
            Icons.arrow_right,
            size: 50,
            color: Colors.white,
          )),
    );
  }
}
