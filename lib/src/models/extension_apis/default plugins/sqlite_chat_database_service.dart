import 'package:chatview/src/models/chat_user.dart';
import 'package:chatview/src/models/extension_apis/default%20plugins/sqflite_user_profile_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/user_profile_service.dart';
import 'package:chatview/src/models/reply_message.dart';
import 'package:chatview/src/models/message.dart';
import 'package:get_it/get_it.dart';

class SqfliteChatDataBaseService extends ChatDataBaseService {
  
  SqfliteChatDataBaseService(
      {required String id,
      required ChatUser currentUser,
      required List<ChatUser> remoteUsers})
      : super(id: id, currentUser: currentUser, remoteUsers: remoteUsers);

  SqfliteUserProfileService get userProfileService =>
      GetIt.I.get<SqfliteUserProfileService>();

  @override
  Future<bool> addMessage(Message message) {
    // TODO: implement addMessage
    throw UnimplementedError();
  }

  @override
  Future<Future<bool>> addMessages(Message msgs) {
    // TODO: implement addMessages

    throw UnimplementedError();
  }

  @override
  Future<int> countOfMessages() {
    // TODO: implement countOfMessages
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMessage(Message message) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Future<Future<bool>> deleteMessages(List<Message> msgs) {
    // TODO: implement deleteMessages
    throw UnimplementedError();
  }

  @override
  Future<Message> fetchMessageById(String id) {
    // TODO: implement fetchMessageById
    throw UnimplementedError();
  }

  @override
  Future<List<Message>> fetchMessageByProperty(List args) {
    // TODO: implement fetchMessageByProperty
    throw UnimplementedError();
  }

  @override
  Future<ReplyMessage> fetchReplyMessage(String replyId) {
    // TODO: implement fetchReplyMessage
    throw UnimplementedError();
  }

  @override
  Future<List<Message>> fetchlastMessages([int limit = 30]) {
    // TODO: implement fetchlastMessages
    throw UnimplementedError();
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement totalMessages
  int get totalMessages => throw UnimplementedError();

  @override
  // TODO: implement unreadMessage
  int get unreadMessage => throw UnimplementedError();



  @override
  Future<bool> updateMessage(Message message) {
    // TODO: implement updateMessage
    throw UnimplementedError();
  }

  @override
  Future<Future<bool>> updateMessages(List<Message> msgs) {
    throw UnimplementedError();
  }
  
  @override
  Future<List<Message>> unreadMessages() {
    // TODO: implement unreadMessages
    throw UnimplementedError();
  }
}
