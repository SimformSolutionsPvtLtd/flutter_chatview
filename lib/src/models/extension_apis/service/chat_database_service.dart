import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models.dart';

class WidgetsExtension {}


abstract class ChatDataBaseService {
  ChatDataBaseService(   
      {required this.id,
      required this.currentUser,
      required this.remoteUsers,
      bool? isGroup,
      this.map}) {
    this.isGroup = isGroup ?? remoteUsers.length > 2;
    init();
  }

  final String id;

  final ChatUser currentUser;

  final List<ChatUser> remoteUsers;

  final List<Message> messages = [];

  final Map<String, dynamic>? map;

  late final bool isGroup;

  int _offset = 0;

  @protected
  int _unread = 0;

  final StreamController<Message> lastMessageStream =
      StreamController<Message>();

  @protected
  void init();

  @protected
  @mustCallSuper
  void dispose() {
    lastMessageStream.close();
  }

  int get totalMessages;

  int get unreadMessage;

  Future<bool> deleteMessage(Message message);

  Future<Future<bool>> deleteMessages(List<Message> msgs);

  Future<bool> addMessage(Message message);

  Future<Future<bool>> addMessages(Message msgs);

  Future<bool> updateMessage(Message message);

  Future<Future<bool>> updateMessages(List<Message> msgs);

  Future<List<Message>> fetchlastMessages([int limit = 30]);

  Future<ReplyMessage?> fetchReplyMessage(String replyId);

  Future<Message?> fetchMessageById(String id);

  Future<int> countOfMessages();

  Future<List<Message>> unreadMessages();

  Map<String, dynamic> toJson();
}
