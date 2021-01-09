import 'package:flutter/material.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/routes/route_names.dart';
import 'package:instantmessage/screens/chat.screen.dart';
import 'package:instantmessage/screens/error.screen.dart';
import 'package:instantmessage/screens/home.screen.dart';
import 'package:instantmessage/screens/login.screen.dart';
import 'package:instantmessage/screens/register.screen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case RouteNames.chat:
        UserModel userModel = settings.arguments;
        return MaterialPageRoute(builder: (_) => ChatScreen(userModel));

      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
    }

    return MaterialPageRoute(builder: (_) => ErrorScreen());
  }
}
