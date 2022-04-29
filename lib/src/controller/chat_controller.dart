import 'dart:async';

import 'package:flutter/material.dart';

import '../models/models.dart';

class ChatController {
  List<Message> initialMessageList;
  ScrollController scrollController;

  ChatController({
    required this.initialMessageList,
    required this.scrollController,
  });

  StreamController<List<Message>> streamController = StreamController();

  void addMessage(Message message) {
    initialMessageList.add(message);
    streamController.sink.add(initialMessageList);
  }

  void setReaction(String emoji, String messageId) {
    final message =
        initialMessageList.firstWhere((element) => element.id == messageId);
    final index = initialMessageList.indexOf(message);
    initialMessageList[index] = Message(
      id: messageId,
      message: message.message,
      createdAt: message.createdAt,
      sendBy: message.sendBy,
      replyMessage: message.replyMessage,
      reaction: emoji,
      messageType: message.messageType,
    );
    streamController.sink.add(initialMessageList);
  }

  void scrollToLastMessage() => Timer(
        const Duration(milliseconds: 300),
        () => scrollController.animateTo(
          scrollController.position.minScrollExtent,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 300),
        ),
      );

  void loadMoreData(List<Message> messageList) {
    initialMessageList.addAll(messageList);
    streamController.sink.add(initialMessageList);
  }
}
