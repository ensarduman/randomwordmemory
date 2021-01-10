import 'package:flutter/material.dart';

class ExitRandomButton extends StatelessWidget {
  final Function onTap;
  const ExitRandomButton({this.onTap});
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
              color: Colors.yellow[100],
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              )),
          child: Icon(
            Icons.close,
            size: 50,
            color: Colors.red,
          )),
    );
  }
}
