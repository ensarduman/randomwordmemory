import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/widgets/login_screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Firebase.app();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          LoginForm(),
          Expanded(
            child: SizedBox(),
          ),
        ],
      )),
    );
  }
}
