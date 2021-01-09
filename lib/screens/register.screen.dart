import 'package:flutter/material.dart';
import 'package:instantmessage/widgets/register_screen/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          RegisterForm(),
          Expanded(
            child: SizedBox(),
          ),
        ],
      )),
    );
  }
}
