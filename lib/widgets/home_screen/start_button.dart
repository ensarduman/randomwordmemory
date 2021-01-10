import 'package:flutter/material.dart';
import 'package:instantmessage/common/enums.dart';
import 'package:instantmessage/routes/route_names.dart';

class StartButton extends StatelessWidget {
  const StartButton();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.random, arguments: EnumDateFilterType.LastWeek);
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              )),
          child: Icon(
            Icons.play_arrow,
            size: 50,
            color: Colors.white,
          )),
    );
  }
}
