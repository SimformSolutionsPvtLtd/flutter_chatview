import 'dart:convert';

import 'package:chatview/src/models/chat_user.dart';
import 'package:chatview/src/models/extension_apis/default%20plugins/sqflite_chatroom_database_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import '../service/user_profile_service.dart';
import 'sqflite_database_service.dart';

class SqfliteUserProfileService extends UserProfileService {
  final String tableName = 'chatUsers';

  @override
  Future<ChatUser?> fetchChatUser(String id) async {
    return serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async {
      final result = await txn.query(tableName, where: 'id = "$id"');
      if (result.isNotEmpty) {
        return ChatUser(
            id: result.first['id'] as String,
            name: result.first['name'] as String,
            map: jsonDecode(result.first['map'] as String)
                as Map<String, dynamic>,
            profilePhoto: result.first['profilePhoto'] as String);
      }
      return null;
    });
  }

  @override
  Future<List<ChatUser>> fetchChatUsers(List<String> userIds) async {
    final response = await serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async {
      return userIds.map((e) async {
        final response = await txn.query(tableName, where: 'id = $e');
        if (response.isNotEmpty) {
          return response.first;
        }
        return {};
      }).toList();
    });
    final result = await Future.wait(response);
    result.removeWhere((element) => element.isEmpty);
    return result
        .map((e) => ChatUser(
            id: e['id'],
            name: e['name'],
            profilePhoto: e['profilePhoto'],
            map: jsonDecode(e['map'] as String)))
        .toList();
  }

  void createChatUser(ChatUser chatUser) async {
    final map = chatUser.toJson();
    map['map'] ??= jsonEncode(chatUser.map);
    await serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async => await txn.insert(tableName, map));
  }


}
