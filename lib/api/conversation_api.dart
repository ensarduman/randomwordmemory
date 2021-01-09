import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantmessage/api/user_api.dart';
import 'package:instantmessage/models/conversation_model.dart';

class ConversationApi {
  Future<String> addOrUpdateConversation(List<String> userids, {String lastmessagecontenttext, String lastmessagefromuserid, String lastmessagefromemail, DateTime lastmessagedate}) async {
    String id;

    try {
      ConversationModel conversationModel = ConversationModel();
      conversationModel.userids = userids;
      conversationModel.lastmessagecontenttext = lastmessagecontenttext;
      conversationModel.lastmessagedate = lastmessagedate;
      conversationModel.lastmessagefromuserid = lastmessagefromuserid;
      conversationModel.lastmessagefromemail = lastmessagefromemail;

      var conversations = await getConversationsByUserIdContains(conversationModel.userids);

      if (conversations.length > 0) {
        conversationModel.id = conversations.first.id;
        await updateConversation(conversationModel.id, conversationModel);
        id = conversationModel.id;
      } else {
        id = await addConversation(conversationModel);
      }
    } catch (error) {
      print(error);
    }

    return id;
  }

  Future<bool> updateConversation(String conversationId, ConversationModel conversationModel) async {
    bool isSuccess = false;

    try {
      CollectionReference conversationsCollection = FirebaseFirestore.instance.collection('conversations');

      var conversationSnapShot = await conversationsCollection.where('id', isEqualTo: conversationId).get();
      var conversationUid = conversationSnapShot.docs.first.id;

      await conversationsCollection.doc(conversationUid).update({
        'lastmessagecontenttext': conversationModel.lastmessagecontenttext,
        'lastmessagefromuserid': conversationModel.lastmessagefromuserid,
        'lastmessagefromemail': conversationModel.lastmessagefromemail,
        'lastmessagedate': conversationModel.lastmessagedate.millisecondsSinceEpoch,
      });
    } catch (error) {
      print(error);
    }

    return isSuccess;
  }

  Future<String> addConversation(ConversationModel conversationModel) async {
    try {
      CollectionReference conversationsCollection = FirebaseFirestore.instance.collection('conversations');

      DocumentReference documentReference = await conversationsCollection.add({
        'id': conversationModel.id,
        'userids': conversationModel.userids,
        'lastmessagecontenttext': conversationModel.lastmessagecontenttext,
        'lastmessagefromuserid': conversationModel.lastmessagefromuserid,
        'lastmessagedate': conversationModel.lastmessagedate == null ? null : conversationModel.lastmessagedate.millisecondsSinceEpoch,
      });

      return conversationModel.id;
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<List<ConversationModel>> getCurrentUserConversations() async {
    List<ConversationModel> conversations;
    var userApi = UserApi();
    var currentUser = await userApi.getCurrentUser();

    if (currentUser != null) {
      conversations = await this.getConversationsByUserId(currentUser.id);
    }

    return conversations;
  }

  Future<List<ConversationModel>> getConversationsByUserId(String userid) async {
    return await getConversationsByUserIdContains([userid]);
  }

  Future<List<ConversationModel>> getConversationsByUserIdContains(List<String> userids) async {
    List<ConversationModel> conversationModels = List<ConversationModel>();
    try {
      Query users;

      if (userids.length > 1) {
        users = FirebaseFirestore.instance.collection('conversations').where('userids', whereIn: [userids.toList(), userids.reversed.toList()]);
      } else {
        users = FirebaseFirestore.instance.collection('conversations').where('userids', arrayContains: userids[0]);
      }

      QuerySnapshot querySnapshot = await users.get();
      if (querySnapshot.size > 0) {
        for (var snapshot in querySnapshot.docs) {
          conversationModels.add(ConversationModel.fromMap(snapshot.data()));
        }
      }

      conversationModels.sort((firstConversation, secondConversation) {
        if (firstConversation.lastmessagedate == null && secondConversation.lastmessagedate == null) {
          return 0;
        } else if (firstConversation.lastmessagedate == null && secondConversation.lastmessagedate != null) {
          return 0;
        } else if (firstConversation.lastmessagedate != null && secondConversation.lastmessagedate == null) {
          return 1;
        } else {
          return secondConversation.lastmessagedate.difference(firstConversation.lastmessagedate).inMilliseconds;
        }
      });
    } catch (error) {
      print(error);
    }

    return conversationModels;
  }
}
