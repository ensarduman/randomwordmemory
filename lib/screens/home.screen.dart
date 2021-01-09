import 'package:flutter/material.dart';
import 'package:instantmessage/widgets/home_screen/conversation_list.dart';
import 'package:instantmessage/widgets/home_screen/home_screen_app_bar.dart';
import 'package:instantmessage/widgets/home_screen/new_conversation_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeScreenAppBar(),
      body: ConversationList(),
      floatingActionButton: NewConversationButton(),
    );
  }
}
