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

import 'package:chatview/src/widgets/suggestions/suggestion_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatview/src/values/enumeration.dart';

import '../models/models.dart';

/// 메시지 업데이트를 위한 데이터 클래스
/// id별로 업데이트할 상태(status)와 (nullable) createdAt 값을 포함합니다.
class MessageUpdate {
  final MessageStatus status;
  final DateTime? createdAt;
  final Map<String, dynamic>? customData;
  final int? unreadCount;

  MessageUpdate({
    required this.status,
    this.createdAt,
    this.customData,
    this.unreadCount,
  });
}

class ChatController {
  /// Represents initial message list in chat which can be add by user.
  List<Message> initialMessageList;

  ScrollController scrollController;

  /// Allow user to show typing indicator defaults to false.
  final ValueNotifier<bool> _showTypingIndicator = ValueNotifier(false);

  /// TypingIndicator as [ValueNotifier] for [GroupedChatList] widget's typingIndicator [ValueListenableBuilder].
  ///  Use this for listening typing indicators
  ///   ```dart
  ///    chatcontroller.typingIndicatorNotifier.addListener((){});
  ///  ```
  /// For more functionalities see [ValueNotifier].
  ValueListenable<bool> get typingIndicatorNotifier => _showTypingIndicator;

  /// Allow user to add reply suggestions defaults to empty.
  final ValueNotifier<List<SuggestionItemData>> _replySuggestion =
      ValueNotifier([]);

  /// newSuggestions as [ValueNotifier] for [SuggestionList] widget's [ValueListenableBuilder].
  ///  Use this to listen when suggestion gets added
  ///   ```dart
  ///    chatcontroller.newSuggestions.addListener((){});
  ///  ```
  /// For more functionalities see [ValueNotifier].
  ValueListenable<List<SuggestionItemData>> get newSuggestions =>
      _replySuggestion;

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
  List<ChatUser> otherUsers;

  /// Provides current user which is sending messages.
  final ChatUser currentUser;

  ChatController({
    required this.initialMessageList,
    required this.scrollController,
    required this.otherUsers,
    required this.currentUser,
  });

  /// Represents message stream of chat
  StreamController<List<Message>> messageStreamController = StreamController();

  /// Used to dispose ValueNotifiers and Streams.
  void dispose() {
    _showTypingIndicator.dispose();
    _replySuggestion.dispose();
    scrollController.dispose();
    messageStreamController.close();
  }

  /// Used to add message in message list.
  void addMessage(Message message) {
    initialMessageList.add(message);
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  void addMessages(List<Message> messages) {
    initialMessageList.addAll(messages);
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// Used to add reply suggestions.
  void addReplySuggestions(List<SuggestionItemData> suggestions) {
    _replySuggestion.value = suggestions;
  }

  /// Used to remove reply suggestions.
  void removeReplySuggestions() {
    _replySuggestion.value = [];
  }

  void syncMessageList(List messageList) {
    initialMessageList = messageList as List<Message>;
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  void deleteMessage(String messageId) {
    initialMessageList.removeWhere((element) => element.id == messageId);
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// 여러 메시지의 상태를 동시에 업데이트합니다.
  ///
  /// [updates] 는 key가 메시지 ID(String),
  /// 값이 해당 메시지의 업데이트 정보인 [MessageUpdate]인 Map입니다.
  ///
  /// 내부적으로 리스트를 역순으로 순회하여, 해당 메시지가 존재하면 업데이트 후에 map에서 제거하며
  /// map이 비면 loop를 즉시 종료하여 성능 최적화를 도모합니다.
  void updateMessagesStatus(Map<String, MessageUpdate> updates) {
    for (int i = initialMessageList.length - 1; i >= 0; i--) {
      final message = initialMessageList[i];
      if (updates.containsKey(message.id)) {
        final update = updates[message.id]!;
        // 메시지 상태 업데이트
        message.setStatus = update.status;
        // createdAt 정보가 있을 경우 업데이트
        if (update.createdAt != null) {
          message.setCreatedAt = update.createdAt!;
        }
        if (update.customData != null) {
          message.customData = update.customData;
        }
        if (update.unreadCount != null) {
          message.setUnreadCount = update.unreadCount!;
        }
        // 해당 업데이트 데이터 제거
        updates.remove(message.id);

        if (!messageStreamController.isClosed) {
          messageStreamController.sink.add(initialMessageList);
        }
      }
      // 모든 업데이트가 처리되었으면 종료
      if (updates.isEmpty) {
        break;
      }
    }
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
      sentBy: message.sentBy,
      replyMessage: message.replyMessage,
      reaction: message.reaction,
      messageType: message.messageType,
      status: message.status,
      unreadCount: message.unreadCount,
      customData: message.customData,
    );
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// Function to scroll to last messages in chat view
  void scrollToLastMessage() => Timer(
        const Duration(milliseconds: 300),
        () {
          if (!scrollController.hasClients) return;
          scrollController.animateTo(
            scrollController.positions.last.minScrollExtent,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
          );
        },
      );

  /// Function for loading data while pagination.
  void loadMoreData(List<Message> messageList) {
    /// Here, we have passed 0 index as we need to add data before first data
    initialMessageList.insertAll(0, messageList);
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// Function for getting ChatUser object from user id
  ChatUser getUserFromId(String userId) => userId == currentUser.id
      ? currentUser
      : otherUsers.firstWhere((element) => element.id == userId);

  /// 주어진 시간 범위 내의 메시지들만 정렬합니다.
  ///
  /// [from] 부터 [to] 까지 사이에 있는 메시지에 대해, 메시지의 [createdAt] 값을 기준으로 오름차순으로 정렬한 후
  /// 해당 위치에 정렬된 순서로 업데이트합니다.
  ///
  /// 예를 들어, 순서가 섞여있는 새로운 메시지들이 수신되었을 경우 해당 시간 구간 내에서만 정렬하여 전체 리스트에 반영합니다.
  void sortMessagesByCreatedAt(DateTime from, DateTime to) {
    // 해당 시간 범위에 포함되는 메시지들의 인덱스와 메시지 객체를 수집합니다.
    final List<int> targetIndices = [];
    final List<Message> targetMessages = [];

    for (int i = 0; i < initialMessageList.length; i++) {
      final message = initialMessageList[i];
      // createdAt 값이 null이 아니고, from 초과 to 미만인 경우에 포함시킵니다.
      if (message.createdAt != null &&
          message.createdAt!.isAfter(from) &&
          message.createdAt!.isBefore(to)) {
        targetIndices.add(i);
        targetMessages.add(message);
      }
    }

    if (targetMessages.isEmpty) return; // 정렬 대상 메시지가 없다면 종료

    // createdAt을 기준으로 오름차순 정렬 (오래된 순으로)
    targetMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    // 정렬된 메시지별로 원래 리스트의 해당 인덱스 위치를 업데이트합니다.
    for (int j = 0; j < targetIndices.length; j++) {
      initialMessageList[targetIndices[j]] = targetMessages[j];
    }

    // 리스트 내의 변경사항을 구독자에게 반영하기 위해 업데이트 이벤트를 발행합니다.
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }
}
