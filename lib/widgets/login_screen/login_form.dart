import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/routes/route_names.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email;
  String password;
  bool navigated = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        if (!navigated) {
          navigated = true;
          Navigator.of(context).pushReplacementNamed(RouteNames.home);
        }
      }
    });
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CustomTextField(
            onChanged: (value) {
              setState(() {
                this.email = value;
              });
            },
            placeHolder: localize(context, 'login_email'),
          ),
          CustomTextField(
            onChanged: (value) {
              setState(() {
                this.password = value;
              });
            },
            obscureText: true,
            placeHolder: localize(context, 'login_password'),
          ),
          MaterialButton(
            child: Text(localize(context, 'login_login')),
            onPressed: () async {
              UserModel userModel = await UserApi().login(this.email, this.password);

              if (userModel == null) {
                ModalHelper.showToast(localize(context, 'login_failed'));
              } else if (!navigated) {
                Navigator.of(context).pushReplacementNamed(RouteNames.home);
              }
            },
          ),
          MaterialButton(
            child: Text(localize(context, 'login_register')),
            onPressed: () async {
              Navigator.of(context).pushNamed(RouteNames.register);
            },
          )
        ],
      ),
    );
  }
}
