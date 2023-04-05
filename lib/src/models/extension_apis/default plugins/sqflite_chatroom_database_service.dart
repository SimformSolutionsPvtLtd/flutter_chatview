import 'dart:convert';

import 'package:chatview/src/models/extension_apis/default%20plugins/sqflite_database_service.dart';
import 'package:chatview/src/models/extension_apis/default%20plugins/sqflite_user_profile_service.dart';
import 'package:chatview/src/models/extension_apis/default%20plugins/sqlite_chat_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_room_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/database_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteChatRoomDataBaseService extends ChatRoomDataBaseService {
  late Database database;

  final String tableName = 'xchatters';

  final userProfileService = GetIt.I.get<SqfliteUserProfileService>();

  @override
  Future<bool> createChatDatabaseServiceInstance(
      ChatDataBaseService chatDBInstance) async {
    return await database.transaction((txn) async {
      return (await txn.insert(tableName, chatDBInstance.toJson())) != 0;
    });
  }

  @override
  Future<bool> deleteChatDataBaseServiceInstance(
      ChatDataBaseService chatDBInstance) async {
    return await database.transaction((txn) async =>
        (await txn.delete(tableName, where: 'id = "${chatDBInstance.id}"')) !=
        0);
  }

  @override
  Future<bool> deleteChatDataBaseServiceInstances(
      List<ChatDataBaseService> chatDBInstances) async {
    if (chatDBInstances.isNotEmpty) {
      return await database.transaction((txn) async {
        final batch = txn.batch();
        for (var i = 0; i < chatDBInstances.length; i++) {
          batch.delete(tableName, where: 'id = "${chatDBInstances[i].id}"');
        }
        return (await batch.commit(continueOnError: true)).isNotEmpty;
      });
    }
    return true;
  }

  @override
  Future<List<ChatDataBaseService>> fetchChatDBIntances([limit = 30]) async {
    final result = (await database.transaction((txn) async {
      return await txn.query(tableName, limit: limit);
    }))
        .map((e) async {
      final currentUser =
          serviceLocator.get<SqfliteDataBaseService>().currentUser;

      final remoteUsers = await userProfileService
          .fetchChatUsers(jsonDecode(e['remoteUsers'] as String));
      if (remoteUsers.isNotEmpty) {
        return SqfliteChatDataBaseService(
            currentUser: currentUser,
            remoteUsers: remoteUsers,
            id: e['id'] as String);
      }
      return null;
    }).toList();

    final response = await Future.wait(result);
    response.removeWhere((element) => element == null);
    response as List<SqfliteChatDataBaseService>;
    return response;
  }

  @override
  void init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demoDataBase.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "create table chatUsers( id text primary key, profilePhoto text, name text, map text );");
      await db.execute(
          "create table $tableName( id text primary key, remoteUsers text, isGroup int, map text );");
    });
  }
}
