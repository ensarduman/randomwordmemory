import 'package:instantmessage/common/helpers/common_helper.dart';

class ConversationModel {
  String id;
  List<String> userids;
  String lastmessagecontenttext;
  String lastmessagefromuserid;
  String lastmessagefromemail;
  DateTime lastmessagedate;

  ConversationModel({
    this.id,
    this.userids,
    this.lastmessagecontenttext,
    this.lastmessagefromuserid,
    this.lastmessagefromemail,
    this.lastmessagedate,
  }) {
    if (id == null) {
      id = generateUniqueId();
    }
  }

  static ConversationModel fromMap(Map<String, dynamic> map) {
    ConversationModel conversationModel = ConversationModel();

    if (map.containsKey('id')) {
      conversationModel.id = map['id'].toString();
    }

    if (map.containsKey('userids')) {
      conversationModel.userids = List.from(map['userids']);
    }

    if (map.containsKey('lastmessagecontenttext')) {
      conversationModel.lastmessagecontenttext = map['lastmessagecontenttext'];
    }

    if (map.containsKey('lastmessagefromuserid')) {
      conversationModel.lastmessagefromuserid = map['lastmessagefromuserid'];
    }

    if (map.containsKey('lastmessagefromemail')) {
      conversationModel.lastmessagefromemail = map['lastmessagefromemail'];
    }

    if (map.containsKey('lastmessagedate')) {
      if (map['lastmessagedate'] != null) {
        conversationModel.lastmessagedate = DateTime.fromMillisecondsSinceEpoch(int.parse(map['lastmessagedate'].toString()) * 1000);
      }
    }

    return conversationModel;
  }
}
