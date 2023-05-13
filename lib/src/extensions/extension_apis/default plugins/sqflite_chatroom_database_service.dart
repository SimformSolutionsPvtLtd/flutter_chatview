import 'dart:convert';
import 'package:chatview/packages/format/format.dart';
import 'package:chatview/src/extensions/extension_apis/default%20plugins/sql_queries.dart';
import 'package:chatview/src/extensions/extension_apis/service/chat_database_service.dart';
import 'package:chatview/src/extensions/extension_apis/service/chat_room_database_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../chatview.dart';

class SqfLiteChatRoomDataBaseService extends ChatRoomDataBaseService {
  late Database database;

  String tableName = "Rooms";

  int _offset = 0;

  final userProfileService = GetIt.I.get<SqfliteUserProfileService>();

  ChatUser currentUser = GetIt.I.get<SqfliteUserProfileService>().currentUser;

  @override
  Future<bool> createRoom(Room room) async {
    return await database.transaction((txn) async {
      return txn.insert(tableName, toDBJsonRoom(room)).then((value) async {
        userProfileService.createChatUsers(room);
        return true;
      });
    });
  }

  @override
  Future<bool> deleteRoom(room) async {
    return await database.transaction((txn) async =>
        (await txn.delete(tableName, where: 'id = "${room.id}" ')) != 0);
  }

  @override
  Future<bool> deleteRooms(List<Room> rooms) async {
    if (rooms.isNotEmpty) {
      return await database.transaction((txn) async {
        final batch = txn.batch();
        for (var i = 0; i < rooms.length; i++) {
          batch.delete(tableName, where: 'id = "${rooms[i].id}"');
        }
        return (await batch.commit(continueOnError: true)).isNotEmpty;
      });
    }
    return true;
  }

  @override
  Future<List<ChatDataBaseService>> fetchRooms([limit = 30]) async {
    final result = (await database.transaction((txn) async {
      return await txn.query(tableName);
    }))
        .map((e) async {
      return SqfliteChatDataBaseService(await fromDBRoom(e));
    }).toList();
    debugPrint("fetching Rooms");
    final response = await Future.wait(result);

    return response;
  }

  @override
  ChatDataBaseService? getInstanceById(String id) {
    try {
      return chatDataBasesNotifier.value
          .firstWhere((element) => element.room.id == id);
    } catch (e) {
      return null;
    }
  }

  deleteMessages() {
    database.transaction((txn) => txn.execute('DROP TABLE MESSAGES'));
  }

  createMessages() {
    database
        .transaction((txn) => txn.execute(PluginQueries.createMessagesTable));
  }

  @override
  init() async {
    database = serviceLocator.get<SqfliteDataBaseService>().database;
    // addRoomsToList(await fetchRooms());
  }
}
