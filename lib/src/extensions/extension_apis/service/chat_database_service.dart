import 'dart:async';

import 'package:chatview/src/values/typedefs.dart';
import 'package:flutter/foundation.dart';

import '../../../models/models.dart';

abstract class ChatDataBaseService {
  ChatDataBaseService(this.room) {
    init();
  }

  final Room room;

  late final bool isGroup;

  final StreamController<Message> lastMessageStream =
      StreamController<Message>.broadcast();

  final MessageNotifierList messages = [];

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

  Future<List<Object?>> deleteMessages(List<Message> msgs);

  Future<bool> addMessage(Message message);

  Future<bool> addMessageWrapper(Message message) async {
    lastMessageStream.sink.add(message);
    return await addMessage(message);
  }

  Future<List<Object?>> addMessages(List<Message> msgs);

  Future<bool> updateMessage(Message message);

  Future<bool> updateReaction(Message message);

  Future<List<Object?>> updateMessages(List<Message> msgs);

  Future<List<Message>> fetchlastMessages();

  Future<Message?> fetchReplyMessage(String replyId);

  Future<Message?> fetchMessageById(String id);

  Future<int> countOfMessages();

  Future<List<Message>> unreadMessages();
}
