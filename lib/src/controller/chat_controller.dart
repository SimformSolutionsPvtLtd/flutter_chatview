/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list_extended/scrollable_positioned_list_extended.dart';
import '../models/models.dart';

class ChatController {
  /// Represents initial message list in chat which can be add by user.
  List<Message> initialMessageList;
  ItemScrollController scrollController;

  /// Allow user to show typing indicator defaults to false.
  final ValueNotifier<bool> _showTypingIndicator = ValueNotifier(false);

  final FocusNode focusNode = FocusNode();

  /// TypingIndicator as [ValueNotifier] for [GroupedChatList] widget's typingIndicator [ValueListenableBuilder].
  ///  Use this for listening typing indicators
  ///   ```dart
  ///    chatcontroller.typingIndicatorNotifier.addListener((){});
  ///  ```
  /// For more functionalities see [ValueNotifier].
  ValueNotifier<bool> get typingIndicatorNotifier => _showTypingIndicator;

  /// Getter for typingIndicator value instead of accessing [_showTypingIndicator.value]
  /// for better accessibility.
  bool get showTypingIndicator => _showTypingIndicator.value;

  /// Setter for changing values of typingIndicator
  /// ```dart
  ///  chatContoller.setTypingIndicator = true; // for showing indicator
  ///  chatContoller.setTypingIndicator = false; // for hiding indicator
  ///  ````
  set setTypingIndicator(bool value) => _showTypingIndicator.value = value;

  /// Represents list of chat users
  List<ChatUser> chatUsers;

  ChatController({
    required this.initialMessageList,
    required this.scrollController,
    required this.chatUsers,
  });

  /// Represents message stream of chat
  StreamController<List<Message>> messageStreamController = StreamController();

  final ValueNotifier<Message?> showMessageActions = ValueNotifier(null);

  final ValueNotifier<bool> showPopUp = ValueNotifier(false);

  /// Used to dispose stream.
  void dispose() => messageStreamController.close();

  /// Used to add message in message list.
  void addMessage(Message message) {
    initialMessageList.insert(0, message);
    messageStreamController.sink.add(initialMessageList);
  }

  void hideReactionPopUp() {
    showPopUp.value = false;
  }

  void deleteMessage(Message message) {
    initialMessageList.removeWhere((element) => element.id == message.id);
    messageStreamController.sink.add(initialMessageList);
  }

  getFocus() {
    focusNode.requestFocus();
  }

  unFocus() {
    focusNode.unfocus();
  }

  scrollToMessage(String replyId) {
    int index =
        initialMessageList.lastIndexWhere((element) => element.id == replyId);
    scrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubicEmphasized,
        alignment: 0.5);
  }

  /// Function for setting reaction on specific chat bubble
  void setReaction({
    required String emoji,
    required String messageId,
    required String userId,
  }) {
    final message =
        initialMessageList.firstWhere((element) => element.id == messageId);
    final reactedUserIds = message.reaction.reactedUserIds;
    final indexOfMessage = initialMessageList.indexOf(message);
    final userIndex = reactedUserIds.indexOf(userId);
    if (userIndex != -1) {
      if (message.reaction.reactions[userIndex] == emoji) {
        message.reaction.reactions.removeAt(userIndex);
        message.reaction.reactedUserIds.removeAt(userIndex);
      } else {
        message.reaction.reactions[userIndex] = emoji;
      }
    } else {
      message.reaction.reactions.add(emoji);
      message.reaction.reactedUserIds.add(userId);
    }
    initialMessageList[indexOfMessage] = Message(
      id: messageId,
      message: message.message,
      createdAt: message.createdAt,
      sendBy: message.sendBy,
      replyMessage: message.replyMessage,
      reaction: message.reaction,
      messageType: message.messageType,
      status: message.status,
    );
    messageStreamController.sink.add(initialMessageList);
  }

  /// Function to scroll to last messages in chat view
  void scrollToLastMessage() {
    Timer(
        const Duration(milliseconds: 300),
        () => scrollController.scrollToMax(
            duration: const Duration(milliseconds: 300)));
  }

  /// Function for loading data while pagination.
  void loadMoreData(List<Message> messageList) {
    initialMessageList.addAll(messageList);
    messageStreamController.sink.add(initialMessageList);
  }

  /// Function for getting ChatUser object from user id
  ChatUser getUserFromId(String userId) =>
      chatUsers.firstWhere((element) => element.id == userId);
}
