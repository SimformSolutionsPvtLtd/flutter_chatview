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
import 'package:chatview/chatview.dart';
import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/widgets/suggestions/suggestion_list.dart';
import 'package:chatview/src/widgets/type_indicator_widget.dart';
import 'package:flutter/material.dart';

import 'chat_bubble_widget.dart';
import 'chat_group_header.dart';

class ChatGroupedListWidget extends StatefulWidget {
  const ChatGroupedListWidget({
    Key? key,
    required this.showPopUp,
    required this.scrollController,
    required this.replyMessage,
    required this.assignReplyMessage,
    required this.onChatListTap,
    required this.onChatBubbleLongPress,
    required this.isEnableSwipeToSeeTime,
  }) : super(key: key);

  /// Allow user to swipe to see time while reaction pop is not open.
  final bool showPopUp;

  /// Pass scroll controller
  final ScrollController scrollController;

  /// Provides reply message if actual message is sent by replying any message.
  final ReplyMessage replyMessage;

  /// Provides callback for assigning reply message when user swipe on chat bubble.
  final MessageCallBack assignReplyMessage;

  /// Provides callback when user tap anywhere on whole chat.
  final VoidCallBack onChatListTap;

  /// Provides callback when user press chat bubble for certain time then usual.
  final void Function(double, double, Message) onChatBubbleLongPress;

  /// Provide flag for turn on/off to see message crated time view when user
  /// swipe whole chat.
  final bool isEnableSwipeToSeeTime;

  @override
  State<ChatGroupedListWidget> createState() => _ChatGroupedListWidgetState();
}

class _ChatGroupedListWidgetState extends State<ChatGroupedListWidget>
    with TickerProviderStateMixin {
  bool get showPopUp => widget.showPopUp;

  bool highlightMessage = false;
  final ValueNotifier<String?> _replyId = ValueNotifier(null);

  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;

  FeatureActiveConfig? featureActiveConfig;

  ChatController? chatController;

  bool get isEnableSwipeToSeeTime => widget.isEnableSwipeToSeeTime;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      chatListConfig.chatBackgroundConfig;

  double chatTextFieldHeight = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    updateChatTextFieldHeight();
  }

  @override
  void didUpdateWidget(covariant ChatGroupedListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateChatTextFieldHeight();
  }

  void updateChatTextFieldHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        chatTextFieldHeight =
            chatViewIW?.chatTextFieldViewKey.currentContext?.size?.height ?? 10;
      });
    });
  }

  void _initializeAnimation() {
    // When this flag is on at that time only animation controllers will be
    // initialized.
    if (isEnableSwipeToSeeTime) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
      );
      _slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          curve: Curves.decelerate,
          parent: _animationController!,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (chatViewIW != null) {
      featureActiveConfig = chatViewIW!.featureActiveConfig;
      chatController = chatViewIW!.chatController;
    }
    _initializeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsListConfig =
        suggestionsConfig?.listConfig ?? const SuggestionListConfig();
    return GestureDetector(
      onHorizontalDragUpdate:
          isEnableSwipeToSeeTime && !showPopUp ? _onHorizontalDrag : null,
      onHorizontalDragEnd: isEnableSwipeToSeeTime && !showPopUp
          ? (details) => _animationController?.reverse()
          : null,
      onTap: widget.onChatListTap,
      child: CustomScrollView(
        reverse: true,
        controller: widget.scrollController,
        physics: showPopUp ? const NeverScrollableScrollPhysics() : null,
        // 화면에 보이지 않는 영역에 대해서도 미리 위젯을 생성하여 스크롤 성능 개선 (필요에 따라 값 조정)
        cacheExtent: 1000,
        slivers: [
          // 메시지 입력 필드 위쪽 여백
          SliverToBoxAdapter(
            child: SizedBox(
              height: chatTextFieldHeight,
            ),
          ),
          // 메시지 리스트 영역 (직접 SliverList 반환)
          _buildMessageSliver(),
          // 타이핑 인디케이터 영역
          if (chatController != null)
            SliverToBoxAdapter(
              child: ValueListenableBuilder(
                valueListenable: chatController!.typingIndicatorNotifier,
                builder: (context, value, child) => TypingIndicator(
                  typeIndicatorConfig: chatListConfig.typeIndicatorConfig,
                  chatBubbleConfig:
                      chatListConfig.chatBubbleConfig?.inComingChatBubbleConfig,
                  showIndicator: value,
                ),
              ),
            ),
          // SuggestionList 영역
          if (chatController != null)
            SliverToBoxAdapter(
              child: Align(
                alignment: suggestionsListConfig.axisAlignment.alignment,
                child: const SuggestionList(),
              ),
            ),
        ],
      ),
    );
  }

  /// 메시지 리스트를 SliverList로 렌더링하는 메서드
  Widget _buildMessageSliver() {
    return StreamBuilder<List<Message>>(
      stream: chatController?.messageStreamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.connectionState.isActive || !snapshot.hasData) {
          // 메시지 데이터가 준비되지 않은 경우 전 영역을 채우는 로딩 위젯 반환
          return SliverFillRemaining(
            child: Center(
              child: chatBackgroundConfig.loadingWidget ??
                  const CircularProgressIndicator(),
            ),
          );
        } else {
          final messages = chatBackgroundConfig.sortEnable
              ? sortMessage(snapshot.data!)
              : snapshot.data!;
          final enableSeparator =
              featureActiveConfig?.enableChatSeparator ?? false;

          // 메시지 및 그룹 separator를 하나의 리스트로 결합
          List<_ChatListItem> items = [];
          if (enableSeparator) {
            DateTime? lastDate;
            // loop backward in the most performant way
            for (var i = messages.length - 1; i >= 0; i--) {
              final message = messages[i];
              // 첫 메시지이거나 날짜가 달라졌다면 separator 추가
              if (lastDate == null ||
                  lastDate.getDateFromDateTime !=
                      message.createdAt.getDateFromDateTime) {
                if (lastDate != null) {
                  items.add(_ChatListItem(separator: lastDate));
                }
                lastDate = message.createdAt;
              }
              items.add(_ChatListItem(message: message));
            }
          } else {
            items = messages.map((m) => _ChatListItem(message: m)).toList();
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                if (item.separator != null) {
                  return _groupSeparator(item.separator!);
                } else {
                  final message = item.message!;
                  final enableScrollToRepliedMsg = chatListConfig
                          .repliedMessageConfig
                          ?.repliedMsgAutoScrollConfig
                          .enableScrollToRepliedMsg ??
                      false;
                  return ValueListenableBuilder<String?>(
                    valueListenable: _replyId,
                    builder: (context, state, child) {
                      return ChatBubbleWidget(
                        key: message.key,
                        message: message,
                        slideAnimation: _slideAnimation,
                        onLongPress: (yCoordinate, xCoordinate) =>
                            widget.onChatBubbleLongPress(
                                yCoordinate, xCoordinate, message),
                        onSwipe: widget.assignReplyMessage,
                        shouldHighlight: state == message.id,
                        onReplyTap: enableScrollToRepliedMsg
                            ? (replyId) => _onReplyTap(replyId, snapshot.data)
                            : null,
                      );
                    },
                  );
                }
              },
              childCount: items.length,
            ),
          );
        }
      },
    );
  }

  Future<void> _onReplyTap(String id, List<Message>? messages) async {
    // Finds the replied message if exists
    final repliedMessages = messages?.firstWhere((message) => id == message.id);
    final repliedMsgAutoScrollConfig =
        chatListConfig.repliedMessageConfig?.repliedMsgAutoScrollConfig;
    final highlightDuration = repliedMsgAutoScrollConfig?.highlightDuration ??
        const Duration(milliseconds: 300);
    // Scrolls to replied message and highlights
    if (repliedMessages != null && repliedMessages.key.currentState != null) {
      await Scrollable.ensureVisible(
        repliedMessages.key.currentState!.context,
        // This value will make widget to be in center when auto scrolled.
        alignment: 0.5,
        curve:
            repliedMsgAutoScrollConfig?.highlightScrollCurve ?? Curves.easeIn,
        duration: highlightDuration,
      );
      if (repliedMsgAutoScrollConfig?.enableHighlightRepliedMsg ?? false) {
        _replyId.value = id;

        Future.delayed(highlightDuration, () {
          _replyId.value = null;
        });
      }
    }
  }

  /// When user swipe at that time only animation is assigned with value.
  void _onHorizontalDrag(DragUpdateDetails details) {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(
      CurvedAnimation(
        curve: chatBackgroundConfig.messageTimeAnimationCurve,
        parent: _animationController!,
      ),
    );

    details.delta.dx > 1
        ? _animationController?.reverse()
        : _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _replyId.dispose();
    super.dispose();
  }

  List<Message> sortMessage(List<Message> messages) {
    final elements = [...messages];
    elements.sort(
      chatBackgroundConfig.messageSorter ??
          (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    if (chatBackgroundConfig.groupedListOrder.isAsc) {
      return elements.toList();
    } else {
      return elements.reversed.toList();
    }
  }

  /// return DateTime by checking lastMatchedDate and message created DateTime
  DateTime _groupBy(
    Message message,
    DateTime lastMatchedDate,
  ) {
    /// If the conversation is ongoing on the same date,
    /// return the same date [lastMatchedDate].

    /// When the conversation starts on a new date,
    /// we are returning new date [message.createdAt].
    return lastMatchedDate.getDateFromDateTime ==
            message.createdAt.getDateFromDateTime
        ? lastMatchedDate
        : message.createdAt;
  }

  Widget _groupSeparator(DateTime createdAt) {
    return featureActiveConfig?.enableChatSeparator ?? false
        ? _GroupSeparatorBuilder(
            separator: createdAt,
            defaultGroupSeparatorConfig:
                chatBackgroundConfig.defaultGroupSeparatorConfig,
            groupSeparatorBuilder: chatBackgroundConfig.groupSeparatorBuilder,
          )
        : const SizedBox.shrink();
  }
}

class _GroupSeparatorBuilder extends StatelessWidget {
  const _GroupSeparatorBuilder({
    Key? key,
    required this.separator,
    this.groupSeparatorBuilder,
    this.defaultGroupSeparatorConfig,
  }) : super(key: key);
  final DateTime separator;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;

  @override
  Widget build(BuildContext context) {
    return groupSeparatorBuilder != null
        ? groupSeparatorBuilder!(separator.toString())
        : ChatGroupHeader(
            day: separator,
            groupSeparatorConfig: defaultGroupSeparatorConfig,
          );
  }
}

/// 메시지와 구분자(separator)를 담기 위한 간단한 클래스
class _ChatListItem {
  final Message? message;
  final DateTime? separator;
  _ChatListItem({this.message, this.separator});
}
