import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/routes/route_names.dart';

class LogoutButton extends StatelessWidget {
  bool _navigated = false;

  Future<void> _logoutAction(BuildContext context) async {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        if (!_navigated) {
          _navigated = true;
          print('User is currently signed out!');
          _logoutAction(context);
        }
      }
    });

    return Container(
      child: InkWell(
        onTap: () {
          ModalHelper.showModalDialog(
            context,
            title: localize(context, 'home_logout_title'),
            contentText: localize(context, 'home_logout_text'),
            buttonOrder: ButtonOrder.vertical,
            firstButtonText: localize(context, 'home_logout_yes'),
            secondButtonText: localize(context, 'home_logout_no'),
            enableFirstButton: true,
            enableSecondButton: true,
            onFirstButtonClick: () async {
              await UserApi().logout();
            },
            onSecondButtonClick: () {
              ModalHelper.closeModals(context);
            },
          );
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
