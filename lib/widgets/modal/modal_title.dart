import 'package:flutter/material.dart';

class ApmModalTitle extends StatelessWidget {
  final String title;

  ApmModalTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: Text(
        this.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey[90],
          height: 1.4,
        ),
      ),
    );
  }
}
