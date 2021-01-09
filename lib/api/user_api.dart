import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instantmessage/models/user_model.dart';

class UserApi {
  Future<bool> addUser(UserModel userModel) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.add({
        'id': userModel.id,
        'credentialid': userModel.credentialid,
        'email': userModel.email,
        'firstname': userModel.firstname,
        'lastname': userModel.lastname,
        'fullname': userModel.fullname,
      });

      return true;
    } catch (error) {
      print("Add User: $error");
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> login(String email, String password) async {
    UserModel userModel;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        userModel = await this.getUserByUserCredentialId(userCredential.user.uid);
      }
    } catch (error) {
      print(error);
    }

    if (userModel == null) {
      this.logout();
    }

    return userModel;
  }

  Future<bool> isLoggedIn() async {
    var currentUser = await this.getCurrentUser();
    return currentUser != null;
  }

  Future<UserModel> getUserByUserCredentialId(String credentialId) async {
    UserModel userModel;
    try {
      Query users = FirebaseFirestore.instance.collection('users').where("credentialid", isEqualTo: credentialId);
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.size > 0) {
        userModel = UserModel.fromMap(querySnapshot.docs.first.data());
      }
    } catch (error) {
      print(error);
    }

    return userModel;
  }

  Future<UserModel> getUserByUserId(String id) async {
    var result = await getUsersByUserIds([id]);
    return result.firstWhere(
      (user) => true,
      orElse: () => null,
    );
  }

  Future<List<UserModel>> getUsersByUserIds(List<String> userids) async {
    List<UserModel> userModels;
    try {
      Query users = FirebaseFirestore.instance.collection('users').where("id", whereIn: userids);
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.size > 0) {
        userModels = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
      }
    } catch (error) {
      print(error);
    }

    return userModels;
  }

  Future<UserModel> getCurrentUser() async {
    UserModel userModel;
    try {
      User currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userModel = await getUserByUserCredentialId(currentUser.uid);
      }
    } catch (error) {
      print(error);
    }

    return userModel;
  }

  Future<List<UserModel>> searchUsersByFullname(String fullnameQuery) async {
    List<UserModel> userModels = List<UserModel>();
    try {
      if (fullnameQuery != null) {
        Query users = FirebaseFirestore.instance.collection('users');
        QuerySnapshot querySnapshot = await users.get();

        if (querySnapshot.size > 0) {
          userModels = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data())).where((user) => user.fullname.toLowerCase().contains(fullnameQuery.toLowerCase())).toList();
        }
      }
    } catch (error) {
      print(error);
    }

    return userModels;
  }
}
