import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantmessage/api/conversation_api.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/message_model.dart';

import 'conversation_api.dart';

class MessageApi {
  Future<String> sendMessage(String toUserId, String contenttext) async {
    String id;

    try {
      //If conversation not exist, new conversation adding
      var userApi = UserApi();
      var conversationApi = ConversationApi();
      var currentUser = await userApi.getCurrentUser();
      var conversations = await conversationApi.getConversationsByUserIdContains([currentUser.id, toUserId]);
      String conversationId;
      if (conversations.length > 0) {
        conversationId = conversations.first.id;
      } else {
        conversationId = await conversationApi.addOrUpdateConversation([currentUser.id, toUserId]);
      }

      MessageModel message = MessageModel(
        contenttext: contenttext,
        conversationid: conversationId,
        date: DateTime.now(),
        fromuserid: currentUser.id,
      );

      CollectionReference messagesCollection = FirebaseFirestore.instance.collection('messages');

      DocumentReference documentReference = await messagesCollection.add({
        'id': message.id,
        'contenttext': message.contenttext,
        'conversationid': message.conversationid,
        'date': message.date.millisecondsSinceEpoch,
        'fromuserid': message.fromuserid,
      });
      var docRef = await documentReference.get();
      message = MessageModel.fromMap(docRef.data());

      await conversationApi.addOrUpdateConversation([currentUser.id, toUserId], lastmessagecontenttext: message.contenttext, lastmessagedate: message.date, lastmessagefromemail: currentUser.email, lastmessagefromuserid: currentUser.id);

      id = message.id;
    } catch (error) {}

    return id;
  }

  Future<Stream<QuerySnapshot>> streamMessagesByUserId(String otherUserId) async {
    var currentUser = await UserApi().getCurrentUser();
    List<String> userIds = [currentUser.id, otherUserId];
    var conversationApi = ConversationApi();
    var conversation = await conversationApi.getConversationsByUserIdContains(userIds);
    String conversationId;
    if (conversation.length == 0) {
      conversationId = await conversationApi.addOrUpdateConversation(userIds);
    } else {
      conversationId = conversation.first.id;
    }
    try {
      var reference = FirebaseFirestore.instance.collection('messages').where("conversationid", isEqualTo: conversationId);
      return reference.snapshots();
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<MessageModel>> getMessagesByConversationId(String conversationid) async {
    List<MessageModel> messageModels = List<MessageModel>();
    try {
      Query users = FirebaseFirestore.instance.collection('messages').where("conversationid", isEqualTo: conversationid);
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.size > 0) {
        for (var snapshot in querySnapshot.docs) {
          messageModels.add(MessageModel.fromMap(snapshot.data()));
        }

        messageModels.sort((firstMessageModel, secondMessageModel) {
          var diff = secondMessageModel.date.difference(firstMessageModel.date);
          return diff.inMilliseconds;
        });
      }
    } catch (error) {
      print(error);
    }

    return messageModels;
  }
}
