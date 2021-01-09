import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/word_model.dart';

class WordApi {
  Future<String> addOrUpdateWord(String userid, {String mylanguagecontent, String targetlanguagecontent, bool islearned, DateTime createdate}) async {
    String id;

    try {
      WordModel wordModel = WordModel();
      wordModel.userid = userid;
      wordModel.mylanguagecontent = mylanguagecontent;
      wordModel.targetlanguagecontent = targetlanguagecontent;
      wordModel.islearned = islearned;
      wordModel.createdate = createdate;

      var words = await getWordsByUserId(wordModel.userid);

      if (words.length > 0) {
        wordModel.id = words.first.id;
        await updateWord(wordModel.id, wordModel);
        id = wordModel.id;
      } else {
        id = await addWord(wordModel);
      }
    } catch (error) {
      print(error);
    }

    return id;
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
        'lastmessagedate': wordModel.createdate.millisecondsSinceEpoch,
      });
    } catch (error) {
      print(error);
    }

    return isSuccess;
  }

  Future<String> addWord(WordModel wordModel) async {
    try {
      CollectionReference wordsCollection = FirebaseFirestore.instance.collection('words');

      await wordsCollection.add({
        'id': wordModel.id,
        'userid': wordModel.userid,
        'mylanguagecontent': wordModel.mylanguagecontent,
        'targetlanguagecontent': wordModel.targetlanguagecontent,
        'islearned': wordModel.islearned,
        'createdate': wordModel.createdate == null ? null : wordModel.createdate.millisecondsSinceEpoch,
      });

      return wordModel.id;
    } catch (error) {
      print(error);
    }

    return null;
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
      Query users;

      users = FirebaseFirestore.instance.collection('words').where('userid', isEqualTo: userid);

      QuerySnapshot querySnapshot = await users.get();
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
}
