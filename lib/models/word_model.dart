import 'package:instantmessage/common/helpers/common_helper.dart';

class WordModel {
  String id;
  String userid;
  String mylanguagecontent;
  String targetlanguagecontent;
  DateTime createdate;

  WordModel({
    this.id,
    this.userid,
    this.mylanguagecontent,
    this.targetlanguagecontent,
    this.createdate,
  }) {
    if (id == null) {
      id = generateUniqueId();
    }
  }

  static WordModel fromMap(Map<String, dynamic> map) {
    WordModel wordModel = WordModel();

    if (map.containsKey('id')) {
      wordModel.id = map['id'].toString();
    }

    if (map.containsKey('userid')) {
      wordModel.userid = map['userid'].toString();
    }

    if (map.containsKey('mylanguagecontent')) {
      wordModel.mylanguagecontent = map['mylanguagecontent'];
    }

    if (map.containsKey('targetlanguagecontent')) {
      wordModel.targetlanguagecontent = map['targetlanguagecontent'];
    }

    if (map.containsKey('createdate')) {
      if (map['createdate'] != null) {
        wordModel.createdate = DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdate'].toString()) * 1000);
      }
    }

    return wordModel;
  }
}
