import 'dart:convert';
import 'package:chatview/chatview.dart';
import 'package:chatview/packages/format/format.dart';
import 'package:chatview/src/extensions/extension_apis/default%20plugins/sql_queries.dart';
import 'package:chatview/src/extensions/extension_apis/service/user_profile_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';

Map<String, dynamic> toDBJsonMessage(Message message, [bool isUpdate = false]) {
  final map = message.toJson();
  map['authorId'] = map['author']['id'];
  map.remove('author');
  map['metadata'] = jsonEncode(map['metadata']);
  map['repliedMessage'] = jsonEncode(map['repliedMessage']);
  map['reaction'] = jsonEncode(map['reaction']);
  print(map);
  return map;
}

Future<Message> fromDBJsonMessage(
    UserProfileService service, Map<String, dynamic> map) async {
  final Map<String, dynamic> json = Map.from(map);
  json['author'] = (await service.fetchChatUser(json['authorId']))?.toJson() ??
      const ChatUser(id: 'chatUser', firstName: 'Undefined ').toJson();
  json['metadata'] = jsonDecode(json['metadata']);
  json['repliedMessage'] = jsonDecode(json['repliedMessage']);
  json['reaction'] = jsonDecode(json['reaction']);
  print(json);
  return Message.fromJson(json);
}

Map<String, dynamic> toDBJsonChatUser(ChatUser chatUser) {
  final map = chatUser.toJson();
  map['metadata'] = jsonEncode(map['metadata']);
  return map;
}

ChatUser fromDBChatUser(Map<String, dynamic> json) {
  final Map<String, dynamic> map = Map.from(json);
  map['metadata'] = jsonDecode(json['metadata']);
  return ChatUser.fromJson(map);
}

Map<String, dynamic> toDBJsonRoom(Room room) {
  final map = room.toJson();

  if (map['lastMessage'] != null) {
    map["lastMessageId"] = map["lastMessage"]["id"];
  }
  if (map['metadata'] != null) {
    map['metadata'] = jsonEncode(map['metadata']);
  }
  map.remove("lastMessage");
  map.remove('users');
  return map;
}

Future<Room> fromDBRoom(Map<String, dynamic> map) async {
  final Map<String, dynamic> json = Map.from(map);
  if (json['metadata'] != null) {
    json['metadata'] = jsonDecode(json['metadata']);
  }
  if (json['lastMessage'] != null) {
    json["lastMessage"] = findLastMessage(json['id']);
  }

  final currentUser = serviceLocator.get<SqfliteDataBaseService>().currentUser;
  final userService =
      serviceLocator.get<SqfliteDataBaseService>().userProfileService;
  final users = await userService.fetchChatUsers(map['id']);
  if (json['type'] == "direct") {
    try {
      final otherUser =
          users.firstWhere((element) => element.id != currentUser.id);

      json['name'] = "${otherUser.firstName} ${otherUser.lastName}";
    } catch (e) {
      json['name'] = null;
    }
  }
  json['users'] = [];
  final room = Room.fromJson(json);
  room.users.addAll(users);
  return room;
}

Future<Message?> findLastMessage(String roomId) async {
  final db = serviceLocator.get<SqfliteDataBaseService>().database;
  return await db.transaction((txn) async {
    final response =
        (await txn.rawQuery(PluginQueries.getLastMessageByRoom.format(roomId)))
            .map((e) async {
      return await fromDBJsonMessage(
          serviceLocator.get<SqfliteDataBaseService>().userProfileService, e);
    }).toList();
    if (response.isNotEmpty) {
      return response.first;
    }
    return null;
  });
}

String directRoomIdProvider(String id1, String id2) {
  if (id1.compareTo(id2) > 0) {
    return "$id2-$id1";
  } else {
    return "$id1-$id2";
  }
}
