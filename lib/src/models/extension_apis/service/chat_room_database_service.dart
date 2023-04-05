import 'dart:async';

import 'chat_database_service.dart';

abstract class ChatRoomDataBaseService {
  
  final List<ChatDataBaseService> chatDataBases = [];

  final StreamController<List<ChatDataBaseService>> chattersStream =
      StreamController<List<ChatDataBaseService>>();

  void init();

  void dispose() {
    chattersStream.close();
  }

  Future<bool> createChatDatabaseServiceInstance(
      ChatDataBaseService chatDBInstance);

  Future<bool> deleteChatDataBaseServiceInstance(
      ChatDataBaseService chatDBInstance);

  Future<bool> deleteChatDataBaseServiceInstances(
      List<ChatDataBaseService> chatDBInstances);

  Future<List<ChatDataBaseService>> fetchChatDBIntances([limit = 30]);
}
