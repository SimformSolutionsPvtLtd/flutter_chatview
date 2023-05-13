import 'package:chatview/packages/format/format.dart';
import 'package:chatview/src/extensions/extension_apis/default%20plugins/sql_queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../chatview.dart';

class SqfliteChatDataBaseService extends ChatDataBaseService {
  SqfliteChatDataBaseService(Room room, {this.limit = 20}) : super(room);

  int _offset = 0;

  final int limit;

  int _unreadOffset = 0;

  final _tableName = 'Messages';

  SqfliteUserProfileService get userProfileService =>
      GetIt.I.get<SqfliteUserProfileService>();

  Database get _database => GetIt.I.get<SqfliteDataBaseService>().database;

  @override
  Future<bool> addMessage(Message message) async {
    return await _database.transaction((txn) async {
      (await txn.insert(_tableName, toDBJsonMessage(message)) != 0);
      return true;
    });
  }

  @override
  Future<List<Object?>> addMessages(List<Message> msgs) async {
    return await _database.transaction((txn) async {
      final batch = txn.batch();
      for (var i = 0; i < msgs.length; i++) {
        batch.insert(_tableName, toDBJsonMessage(msgs[i]));
      }
      return await batch.commit(continueOnError: true);
    });
  }

  @override
  Future<int> countOfMessages() async {
    return await _database.transaction((txn) async =>
        Sqflite.firstIntValue(await txn
            .rawQuery(PluginQueries.countOfMessagesByRoomId.format(room.id))) ??
        0);
  }

  @override
  Future<bool> deleteMessage(Message message) async {
    messages.removeWhere((element) => element.value.id == message.id);
    return await _database.transaction((txn) async =>
        (await txn.delete(_tableName, where: 'id == "${message.id}"')) != 0);
  }

  @override
  Future<List<Object?>> deleteMessages(List<Message> msgs) async {
    return await _database.transaction((txn) async {
      final batch = txn.batch();
      for (var i = 0; i < msgs.length; i++) {
        messages.removeWhere((element) => element.value.id == msgs[i].id);
        batch.delete(_tableName, where: 'id == "${msgs[i].id}"');
      }
      return await batch.commit(continueOnError: true);
    });
  }

  @override
  Future<Message?> fetchMessageById(String id) async {
    return await _database.transaction((txn) async {
      final response = await txn.query(id, where: 'id = "$id');
      return response.isNotEmpty
          ? fromDBJsonMessage(userProfileService, response.first)
          : null;
    });
  }

  @override
  Future<Message?> fetchReplyMessage(String replyId) async {
    return null;
  }

  @override
  Future<List<Message>> fetchlastMessages([setList = true]) async {
    final result = await _database.transaction((txn) async {
      return (await txn.rawQuery(PluginQueries.getAllMessagesByLimit
              .format(room.id, limit, _offset)))
          .map((e) async {
        return await fromDBJsonMessage(userProfileService, e);
      }).toList();
    });

    final response = await Future.wait(result);
    if (setList) {
      _offset += response.length;
      _updateLastMessageStream(response);
    }

    return response;
  }

  @override
  void init() async {
    await fetchlastMessages();
  }

  @override
  int get totalMessages => messages.length;

  @override
  int get unreadMessage => messages
      .where((x) => x.value.status == MessageStatus.delivered)
      .toList()
      .length;

  @override
  Future<bool> updateMessage(Message message) async {
    return await _database.transaction((txn) async => (await txn
            .rawUpdate(PluginQueries.updateQuery(toDBJsonMessage(message))) !=
        0));
  }
  // ''' UPDATE Messages SET status = "${message.status.name}" WHERE id = "${message.id}"  ''')) !=

  @override
  Future<bool> updateReaction(Message message) async {
    return await _database.transaction((txn) async =>
        (await txn.rawUpdate(PluginQueries.updateReaction
            .format(toDBJsonMessage(message)["reaction"], message.id))) !=
        0);
  }

  @override
  Future<List<Object?>> updateMessages(List<Message> msgs) async {
    return await _database.transaction((txn) async {
      final batch = txn.batch();
      for (var i = 0; i < msgs.length; i++) {
        batch.update(_tableName, toDBJsonMessage(msgs[i]),
            where: "id = ${[msgs[i].id]}");
      }
      return await batch.commit(continueOnError: true);
    });
  }

  _updateLastMessageStream(List<Message> msgs) {
    messages.addAll(msgs.map((e) => ValueNotifier(e)));
    if (msgs.isNotEmpty && !(_offset > limit)) {
      lastMessageStream.sink.add(msgs.first);
    }
  }

  @override
  Future<List<Message>> unreadMessages() async {
    List<Message> responseList = [];
    responseList.addAll((messages.where(
            (element) => element.value.status == MessageStatus.delivered))
        .map((e) => e.value));
    await _database.transaction((txn) async {
      final response = (await txn.query(_tableName,
              offset: _unreadOffset,
              limit: 30,
              orderBy: 'createdAt desc ',
              where: 'status = "delivered AND roomId  =  "${room.id}"'))
          .map((e) async {
        _unreadOffset += 1;
        return await fromDBJsonMessage(userProfileService, e);
      }).toList();
      responseList.addAll(await Future.wait(response));
    });
    return responseList;
  }
}
