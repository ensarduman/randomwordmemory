import 'package:instantmessage/common/helpers/common_helper.dart';

class MessageModel {
  String id;
  String conversationid;
  String fromuserid;
  String contenttext;
  DateTime date;

  MessageModel({
    this.id,
    this.conversationid,
    this.fromuserid,
    this.contenttext,
    this.date,
  }) {
    if (id == null) {
      id = generateUniqueId();
    }
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    MessageModel messageModel = MessageModel();

    if (map.containsKey('id')) {
      messageModel.id = map['id'].toString();
    }

    if (map.containsKey('conversationid')) {
      messageModel.conversationid = map['conversationid'].toString();
    }

    if (map.containsKey('fromuserid')) {
      messageModel.fromuserid = map['fromuserid'].toString();
    }

    if (map.containsKey('contenttext')) {
      messageModel.contenttext = map['contenttext'].toString();
    }

    if (map.containsKey('date')) {
      messageModel.date = DateTime.fromMillisecondsSinceEpoch(int.parse(map['date'].toString()) * 1000);
    }

    return messageModel;
  }
}
