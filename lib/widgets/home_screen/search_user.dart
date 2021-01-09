import 'package:flutter/material.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/models/user_model.dart';
import 'package:instantmessage/widgets/custom_text_field.dart';
import 'package:instantmessage/widgets/home_screen/search_user_results.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  // String searchText;
  List<UserModel> users = List<UserModel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          onChanged: (value) {
            var userApi = UserApi();
            userApi.searchUsersByFullname(value).then((searchedUsers) {
              setState(() {
                users = searchedUsers;
              });
            });
          },
          placeHolder: localize(context, 'home_search_user_text_place_holder'),
        ),
        SearchUserResults(users: users),
      ],
    );
  }
}
