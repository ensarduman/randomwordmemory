import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/word_model.dart';

class WordApi {
  Future<String> addOrUpdateWord({String wordId, String mylanguagecontent, String targetlanguagecontent, bool islearned = false}) async {
    try {
      UserApi userApi = UserApi();
      var currentUser = await userApi.getCurrentUser();

      WordModel wordModel = WordModel();
      wordModel.userid = currentUser.id;
      wordModel.mylanguagecontent = mylanguagecontent;
      wordModel.targetlanguagecontent = targetlanguagecontent;
      wordModel.islearned = islearned;

      if (wordId != null) {
        wordModel.id = wordId;
        await updateWord(wordModel.id, wordModel);
      } else {
        wordId = await addWord(wordModel);
      }
    } catch (error) {
      print(error);
    }

    return wordId;
  }

  Future<bool> updateWord(String wordId, WordModel wordModel) async {
    bool isSuccess = false;

    try {
      CollectionReference wordsCollection = FirebaseFirestore.instance.collection('words');

      var wordSnapShot = await wordsCollection.where('id', isEqualTo: wordId).get();
      var wordUid = wordSnapShot.docs.first.id;

      await wordsCollection.doc(wordUid).update({
        'mylanguagecontent': wordModel.mylanguagecontent,
        'targetlanguagecontent': wordModel.targetlanguagecontent,
        'islearned': wordModel.islearned,
      });

      return isSuccess;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> addWord(WordModel wordModel) async {
    try {
      CollectionReference wordsCollection = FirebaseFirestore.instance.collection('words');

      var result = await wordsCollection.add({
        'id': wordModel.id,
        'userid': wordModel.userid,
        'mylanguagecontent': wordModel.mylanguagecontent,
        'targetlanguagecontent': wordModel.targetlanguagecontent,
        'islearned': wordModel.islearned,
        'createdate': wordModel.createdate == null ? DateTime.now().microsecondsSinceEpoch : wordModel.createdate.millisecondsSinceEpoch,
      });

      return result.id;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<WordModel>> getCurrentUserWords() async {
    List<WordModel> words;
    var userApi = UserApi();
    var currentUser = await userApi.getCurrentUser();

    if (currentUser != null) {
      words = await this.getWordsByUserId(currentUser.id);
    }

    return words;
  }

  Future<List<WordModel>> getWordsByUserId(String userid) async {
    List<WordModel> wordModels = List<WordModel>();
    try {
      Query words;

      words = FirebaseFirestore.instance.collection('words').where('userid', isEqualTo: userid);

      QuerySnapshot querySnapshot = await words.get();
      if (querySnapshot.size > 0) {
        for (var snapshot in querySnapshot.docs) {
          wordModels.add(WordModel.fromMap(snapshot.data()));
        }
      }

      wordModels.sort((firstWord, secondWord) {
        if (firstWord.createdate == null && secondWord.createdate == null) {
          return 0;
        } else if (firstWord.createdate == null && secondWord.createdate != null) {
          return 0;
        } else if (firstWord.createdate != null && secondWord.createdate == null) {
          return 1;
        } else {
          return secondWord.createdate.difference(firstWord.createdate).inMilliseconds;
        }
      });
    } catch (error) {
      print(error);
    }

    return wordModels;
  }

  Future<WordModel> getWordById(String id) async {
    WordModel wordModel = WordModel();
    try {
      Query users;

      users = FirebaseFirestore.instance.collection('words').where('id', isEqualTo: id);

      QuerySnapshot querySnapshot = await users.get();
      if (querySnapshot.size > 0) {
        wordModel = WordModel.fromMap(querySnapshot.docs[0].data());
      }
    } catch (error) {
      print(error);
    }

    return wordModel;
  }
}
