import 'package:instantmessage/common/helpers/common_helper.dart';

class UserModel {
  String id;
  String credentialid;
  String email;
  String _firstname;
  String _lastname;
  String _fullname;

  UserModel() {
    id = generateUniqueId();
  }

  String get fullname {
    return this._fullname;
  }

  String get firstname {
    return this._firstname;
  }

  set firstname(String value) {
    this._firstname = value;
    this._refreshFullname();
  }

  String get lastname {
    return this._lastname;
  }

  set lastname(String value) {
    this._lastname = value;
    this._refreshFullname();
  }

  void _refreshFullname() {
    this._fullname = '$_firstname $_lastname';
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    UserModel userModel = UserModel();

    if (map.containsKey('id')) {
      userModel.id = map['id'];
    }
    if (map.containsKey('credentialid')) {
      userModel.credentialid = map['credentialid'];
    }
    if (map.containsKey('email')) {
      userModel.email = map['email'];
    }
    if (map.containsKey('firstname')) {
      userModel.firstname = map['firstname'];
    }
    if (map.containsKey('lastname')) {
      userModel.lastname = map['lastname'];
    }

    return userModel;
  }
}
