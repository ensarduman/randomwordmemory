import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String email;
  String firstname;
  String lastname;
  String password;
  String repassword;

  Future<bool> _registerUser() async {
    bool isRegistered = false;
    String errors = "";
    try {
      if (email == null || email == "" || email.contains(" ")) {
        errors += localize(context, 'register_error_emailwrong') + ". ";
      }

      if (firstname == null || firstname == "") {
        errors += localize(context, 'register_error_firstnamewrong') + ". ";
      }

      if (lastname == null || lastname == "") {
        errors += localize(context, 'register_error_lastnamewrong') + ". ";
      }

      if (password == null || password == "") {
        errors += localize(context, 'register_error_passwordwrong') + ". ";
      }

      if (repassword == null || repassword == "") {
        errors += localize(context, 'register_error_repasswordwrong') + ". ";
      }

      if (password != repassword) {
        errors += localize(context, 'register_error_passwordnotmatching') + ". ";
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );

      isRegistered = errors == "";

      if (isRegistered) {
        UserModel userModel = UserModel();

        userModel.credentialid = userCredential.user.uid;
        userModel.email = this.email;
        userModel.firstname = this.firstname;
        userModel.lastname = this.lastname;

        UserApi().addUser(userModel);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errors += localize(context, 'register_error_passwordweak') + ". ";
      } else if (e.code == 'email-already-in-use') {
        errors += localize(context, 'register_error_emailexists') + ". ";
      } else {
        errors += localize(context, 'register_error_general') + ". ";
      }
    } catch (e) {
      print(e);
    }

    if (!isRegistered) {
      ModalHelper.showToast(errors);
    }

    return isRegistered;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CustomTextField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            placeHolder: localize(context, 'register_email'),
          ),
          CustomTextField(
            onChanged: (value) {
              setState(() {
                firstname = value;
              });
            },
            placeHolder: localize(context, 'register_firstname'),
          ),
          CustomTextField(
            onChanged: (value) {
              setState(() {
                lastname = value;
              });
            },
            placeHolder: localize(context, 'register_lastname'),
          ),
          CustomTextField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
            placeHolder: localize(context, 'register_password'),
          ),
          CustomTextField(
            onChanged: (value) {
              setState(() {
                repassword = value;
              });
            },
            obscureText: true,
            placeHolder: localize(context, 'register_repassword'),
          ),
          MaterialButton(
            child: Text(localize(context, 'register_register')),
            onPressed: () async {
              bool isRegistered = await _registerUser();

              if (isRegistered) {
                Navigator.of(context).pop();
              }
            },
          ),
          MaterialButton(
            child: Text(localize(context, 'register_cancel')),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
