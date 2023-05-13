import 'package:chatview/packages/format/format.dart';
import 'package:chatview/src/extensions/extension_apis/default%20plugins/sql_queries.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../chatview.dart';
import '../service/user_profile_service.dart';

class SqfliteUserProfileService extends UserProfileService {
  SqfliteUserProfileService(this.currentUser, this.db);

  final String tableName = 'ChatUser';
  final Database db;
  final ChatUser currentUser;

  @override
  Future<ChatUser?> fetchChatUser(String id) async {
    return serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async {
      final result = await txn.query(tableName, where: 'id = "$id"');
      if (result.isNotEmpty) {
        return fromDBChatUser(result.first);
      }
      return null;
    });
  }

  @override
  Future<List<ChatUser>> fetchChatUsers(String roomId) async {
    final response = await serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async => await txn
            .rawQuery(PluginQueries.getRoomUsers.format(roomId, 30, 0)));

    /// Limits and offset are mentioned at 30 and 0 respectively.

    return response.map((e) => fromDBChatUser(e)).toList();
  }

  void createChatUser(ChatUser chatUser) async {
    await serviceLocator.get<SqfliteDataBaseService>().database.transaction(
        (txn) async => await txn.insert(tableName, toDBJsonChatUser(chatUser)));
  }

  Future<List<ChatUser>> fetchChannelUsers(String id) async =>
      await db.transaction((txn) async => (await txn.rawQuery(
              'SELECT * FROM RoomUsers INNER JOIN ChatUser on RoomUsers.userId = ChatUser.id AND RoomUsers.roomId = "$id";'))
          .map((e) => ChatUser.fromJson(e))
          .toList());

  Future<List<ChatUser>> fetchUsers() async {
    final response = await serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async {
      return await txn.query('ChatUser', limit: 30, offset: 0);
    });
    return response.map((e) => fromDBChatUser(e)).toList();
  }

  @override
  void createChatUsers(room) async {
    await serviceLocator
        .get<SqfliteDataBaseService>()
        .database
        .transaction((txn) async {
      final batch = txn.batch();
      for (var i = 0; i < room.users.length; i++) {
        batch.insert(
            'RoomUsers', {"roomId": room.id, "userId": room.users[i].id});
      }
      await batch.commit();
    });
  }
}
