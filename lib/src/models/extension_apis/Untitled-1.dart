// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:scrollup/serviceLocator.dart';
// import 'package:scrollup/src/backend/database/local_database/local_database.dart';
// import 'package:scrollup/src/backend/database/local_database/models/user_and_chat_model.dart';
// import 'package:scrollup/src/helpers/chat_helper.dart';
// import 'package:scrollup/utils.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:chatview/chatview.dart';
// import 'package:uuid/uuid.dart';

// import '../../../pages/chat/data.dart';

// class Chatter {
//   Chatter({
//     required this.remoteUser,
//     required this.currentUser,
//   }) {
//     init();
//   }

//   init() async {
//     _db = serviceLocator.get<LocalDatabase>().database;
//     await createUserChat();
//     await fetchLastMessagesFromDB(limit: 10);
//     convertToMessages();
//     initializeChatController();
//   }

//   final String currentUser;

//   final String remoteUser;

//   final ValueNotifier<List<UserChat?>> messages = ValueNotifier([]);

//   final ValueNotifier<List<Message>> messagesList = ValueNotifier([]);

// final StreamController<Message> _messageStream =
//     StreamController<Message>.broadcast();

//   Stream<Message> get newMessages => _messageStream.stream;

//   List<ChatUser> list = [
//     ChatUser(
//       id: 'yogesh',
//       name: 'yogesh',
//     ),
//     ChatUser(
//       id: 'B8BDRcQryQUgHMLVKe5kghg6kAH2',
//       name: 'Simform',
//       // profilePhoto: Data.profileImage,
//     ),
//   ];

//   late final ChatController chatController;

//   Database? _db;

//   int _offset = 0;

//   /// Below all methods are instance specific
//   UserChat? get lastMessage => _getLastMessage();

//   /// will delete a specific Message
//   Future<int> deleteMessage(String un) async {
//     try {
//       messages.value
//           .removeAt(messages.value.indexWhere((element) => element?.uid == un));
//       await _db!.transaction((txn) async {
//         print(un);
//         await txn.execute('DELETE FROM $remoteUser WHERE uid = "$un"  ');
//       });

//       return 1;
//     } catch (e) {
//       return -1;
//     }
//   }

//   initializeChatController() {
//     chatController = ChatController(
//         initialMessageList: messagesList.value,
//         scrollController: ScrollController(),
//         chatUsers: [
//           ChatUser(
//             id: 'B8BDRcQryQUgHMLVKe5kghg6kAH2',
//             name: 'Simform',
//             // profilePhoto: Data.profileImage,
//           ),
//         ]);
//   }

//   void addMessageToStream(UserChat chat) {
//     Message message = chat.toMessage(chat, getReplyMessage(chat.replyMessage));
//     _messageStream.add(message);
//     updateList(message);
//     addMessage(toUserChat(message));
//   }

//   UserChat? _getLastMessage() {
//     if (messages.value.isEmpty) {
//       return null;
//     } else {
//       return messages.value.last;
//     }
//   }

//   /// will delete multiple messages
//   void deleteMessages(List<String> ids) async {
//     Batch? batch = _db?.batch();
//     for (var element in ids) {
//       batch?.delete(remoteUser, where: 'uid = $element');
//     }
//     await batch?.commit();
//   }

//   void addMessages(List<UserChat> userChats) async {
//     Batch? batch = _db?.batch();
//     for (var element in userChats) {
//       batch?.insert(remoteUser, element.toJson());
//     }
//     await batch?.commit();
//   }

//   Future<List<UserChat>?> fetchLastMessagesFromDB({int limit = 50}) async {
//     List<Map<String, Object?>>? result;
//     await _db?.transaction((txn) async {
//       result = await txn.query(
//         remoteUser,
//         limit: limit,
//         orderBy: "serial DESC",
//         offset: _offset,
//       );
//     });
//     return result?.map((e) {
//       Map<String, dynamic> map = Map.from(e);
//       map['reactions'] = jsonDecode(e['reactions'] as String) as List<dynamic>;
//       map['reactionUserIds'] =
//           jsonDecode(e['reactionUserIds'] as String) as List<dynamic>;
//       UserChat response = UserChat.fromJson(map);
//       // updateList(response);
//       messages.value.insert(0, response);
//       _offset += 1;
//       return response;
//     }).toList();
//   }

//   Future<int> createUserChat() async {
//     if (_db != null && _db!.isOpen) {
//       try {
//         await _db!.transaction((txn) async {
//           return await txn.execute(
//               'CREATE TABLE  IF NOT EXISTS $remoteUser( serial INTEGER PRIMARY key  AUTOINCREMENT, uid TEXT  ,sentBy TEXT NOT NULL, sentTo TEXT NOT NULL, type TEXT CHECK (type IN ("text","audio","video")) NOT NULL DEFAULT "text",body Text Not NULL,state TEXT CHECK ( state IN ("unread","read","pending","delivered","sending") ) default "pending",createdAt INT,recivedAt int , replyMessage TEXT,deliveredAt int,reactions TEXT,reactionUserIds Text)');
//         });
//         return 1;
//       } catch (e) {
//         print(e);
//         return -1;
//       }
//     }
//     return -1;
//   }

//   deleteMessagesTable() async {
//     await _db?.transaction((txn) async {
//       await txn.execute('DROP TABLE $remoteUser');
//       print('table deleted');
//     });
//   }

//   Future<int> addMessage(UserChat userChat) async {
//     // updateList(userChat);
//     if (_db != null && _db!.isOpen) {
//       try {
//         print(userChat.toJson());
//         await _db!.transaction((txn) async {
//           Map<String, dynamic> newMap = userChat.toJson();
//           newMap['reactions'] = jsonEncode(newMap['reactions']);
//           newMap['reactionUserIds'] = jsonEncode(newMap['reactionUserIds']);
//           await txn.insert(remoteUser, newMap);
//         });
//         return 1;
//       } catch (e) {
//         print(e);
//         return -1;
//       }
//     }
//     return -1;
//   }

//   Future<int> updateUserChat(UserChat chat) async {
//     try {
//       _db!.transaction((txn) async {
//         Map<String, dynamic> newMap = chat.toJson();
//         newMap['reactions'] = jsonEncode(newMap['reactions']);
//         newMap['reactionUserIds'] = jsonEncode(newMap['reactionUserIds']);
//         await txn.update(remoteUser, newMap, where: 'uid = "${chat.uid}"');
//       });
//       return 1;
//     } catch (e) {
//       return -1;
//     }
//   }

//   updateMessages(List<UserChat> chats) async {
//     try {
//       Batch? batch = _db?.batch();
//       for (var element in chats) {
//         batch?.update(remoteUser, element.toJson());
//         await batch?.commit();
//       }
//     } catch (e) {}
//   }

//   Future<int> updateEmoji(Message message, String emoji) async {
//     UserChat userChat = toUserChat(message);

//     List<String> reactionUserIds = List.from(message.reaction.reactedUserIds);
//     if (!reactionUserIds.contains(currentUser)) {
//       reactionUserIds.add(currentUser);
//     }
//     // reactionUserIds.add();
//     UserChat newChat =
//         userChat.copyWith(reactions: [emoji], reactionUserIds: reactionUserIds);
//     print('toJson ${newChat.toJson()}');
//     int result = await updateUserChat(userChat);
//     // print(result);
//     return 1;
//   }

//   void updateList(Message newMessage) {
//     List<Message> newList = List.from(messagesList.value);
//     newList.add(newMessage);
//     messagesList.value = newList;
//   }

//   void deleteTable() {}

//   void createTable() {}

//   UserChat? fetchMessageById(String uid) {
//     if (messages.value.isNotEmpty) {
//       // return
//       List<UserChat?> chats =
//           messages.value.where((element) => element?.uid == uid).toList();

//       if (chats.isNotEmpty) {
//         return chats[0];
//       }
//       return null;
//     }
//     return null;
//   }

// ReplyMessage? getReplyMessage(String? uid) {
//   List<UserChat?> mes =
//       messages.value.where((element) => element?.uid == uid).toList();
//   print(' mes ${mes.length}');

//   if (mes.isNotEmpty && mes[0] != null) {
//     print(' mes $mes');
//     ReplyMessage answer = ReplyMessage(
//       messageId: uid!,
//       message: mes[0]!.body,
//       replyTo: mes[0]!.sentTo,
//       replyBy: mes[0]!.sentBy,
//       messageType: mes[0]!.type,
//     );
//     return answer;
//   }
//   return null;
// }

//   convertToMessages() {
//     return messages.value.map((e) {
//       Message? message = e?.toMessage(
//           e, e.replyMessage != '' ? getReplyMessage(e.replyMessage) : null);
//       if (message != null) {
//         print('adding Messages');
//         print('message ${message.replyMessage.messageType}');

//         messagesList.value.add(message);
//         return message;
//       }
//     }).toList();
//   }

//   void feedMessagesToTable() async {
//     for (int i = 1; i < 50; i++) {
//       await addMessage(UserChat(
//           recivedAt: DateTime.now().millisecondsSinceEpoch,
//           body: generateRandomString(100),
//           createdAt: DateTime.now().millisecondsSinceEpoch,
//           sentBy: list[Random().nextInt(2)].id,
//           sentTo: list[Random().nextInt(2)].id,
//           state: MessageState.read,
//           type: MessageType.text,
//           deliveredAt: DateTime.now().millisecondsSinceEpoch,
//           uid: Uuid().v4()));
//       print('messages inserted $i');
//     }
//   }

//   UserChat toUserChat(Message message) {
//     UserChat chat = UserChat(
//         recivedAt: message.createdAt.millisecondsSinceEpoch,
//         body: message.message,
//         createdAt: message.createdAt.millisecondsSinceEpoch,
//         sentBy: message.sendBy,
//         sentTo: remoteUser,
//         state: MessageState.pending,
//         type: message.messageType,
//         replyMessage: message.replyMessage.messageId,
//         reactions: message.reaction.reactions,
//         reactionUserIds: message.reaction.reactedUserIds,
//         deliveredAt: DateTime.now().millisecondsSinceEpoch,
//         uid: message.id);
//     print('from toUSerChat ${chat.toJson()}');
//     return chat;
//   }

//   update(Message message) async {
//     // messagesList.value.add(message);
//     // print(message.replyMessage.messageId == '');
//     updateList(message);
//     addMessage(toUserChat(message));
//     serviceLocator
//         .get<ChatHelper>()
//         .xmppHelper
//         .sendMessage(toUserChat(message));
//     print('Added Completely');
//   }
//   // Future<List<UserChat>> fetchUnreadMessages(String remoteUser) {}
// }
