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
import 'package:chatview/src/widgets/type_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'chat_bubble_widget.dart';
import 'chat_group_header.dart';

class ChatGroupedListWidget extends StatefulWidget {
  const ChatGroupedListWidget({
    Key? key,
    required this.showPopUp,
    required this.showTypingIndicator,
    required this.scrollController,
    required this.chatController,
    required this.chatBackgroundConfig,
    required this.showReceiverProfileCircle,
    required this.replyMessage,
    required this.assignReplyMessage,
    required this.onChatListTap,
    required this.onChatBubbleLongPress,
    required this.currentUser,
    this.messageConfig,
    this.chatBubbleConfig,
    this.profileCircleConfig,
    this.swipeToReplyConfig,
    this.repliedMessageConfig,
    this.typeIndicatorConfig,
  }) : super(key: key);

  // Allow user to swipe to see time while reaction pop is not open.
  final bool showPopUp;

  // Allow user to show typing indicator.
  final bool showTypingIndicator;
  final ScrollController scrollController;

  // Allow user to use predefine methods.
  final ChatController chatController;

  // Allow user to give customisation to background of chat
  final ChatBackgroundConfiguration chatBackgroundConfig;

  // Allow user to showing user profile picture in message.
  final bool showReceiverProfileCircle;

  // Allow user to giving customisation different types
  // messages
  final MessageConfiguration? messageConfig;

  // Allow user to giving customisation to chat bubble
  final ChatBubbleConfiguration? chatBubbleConfig;

  // Allow user to giving customisation to profile circle
  final ProfileCircleConfiguration? profileCircleConfig;

  // Allow user to giving customisation to swipe to reply
  final SwipeToReplyConfiguration? swipeToReplyConfig;
  final RepliedMessageConfiguration? repliedMessageConfig;

  // Allow user to giving customisation typing indicator
  final TypeIndicatorConfiguration? typeIndicatorConfig;
  final ReplyMessage replyMessage;
  final MessageCallBack assignReplyMessage;
  final VoidCallBack onChatListTap;
  final void Function(double, double, Message) onChatBubbleLongPress;
  final ChatUser currentUser;

  @override
  State<ChatGroupedListWidget> createState() => _ChatGroupedListWidgetState();
}

class _ChatGroupedListWidgetState extends State<ChatGroupedListWidget>
    with SingleTickerProviderStateMixin {
  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  ChatController get chatController => widget.chatController;

  bool get horizontalDragToShowTime =>
      chatBackgroundConfig.horizontalDragToShowMessageTime;

  bool get showPopUp => widget.showPopUp;

  bool get showTypingIndicator => widget.showTypingIndicator;

  bool highlightMessage = false;
  String? _replyId;

  ChatBubbleConfiguration? get chatBubbleConfig => widget.chatBubbleConfig;

  ProfileCircleConfiguration? get profileCircleConfig =>
      widget.profileCircleConfig;
  late final AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    if (chatBackgroundConfig.horizontalDragToShowMessageTime) {
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
          parent: _animationController,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      physics: showPopUp ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.only(bottom: showTypingIndicator ? 50 : 0),
      controller: widget.scrollController,
      child: Column(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) => horizontalDragToShowTime
                ? showPopUp
                    ? null
                    : _onHorizontalDrag(details)
                : null,
            onHorizontalDragEnd: (details) => horizontalDragToShowTime
                ? showPopUp
                    ? null
                    : _animationController.reverse()
                : null,
            onTap: widget.onChatListTap,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return StreamBuilder<List<Message>>(
                  stream: chatController.messageStreamController.stream,
                  builder: (context, snapshot) {
                    return snapshot.connectionState.isActive
                        ? GroupedListView<Message, String>(
                            shrinkWrap: true,
                            elements: snapshot.data!,
                            groupBy: (element) =>
                                element.createdAt.getDateFromDateTime,
                            itemComparator: (message1, message2) =>
                                message1.message.compareTo(message2.message),
                            physics: const NeverScrollableScrollPhysics(),
                            order: chatBackgroundConfig.groupedListOrder,
                            sort: chatBackgroundConfig.sortEnable,
                            groupSeparatorBuilder: (separator) =>
                                _GroupSeparatorBuilder(
                              separator: separator,
                              defaultGroupSeparatorConfig: chatBackgroundConfig
                                  .defaultGroupSeparatorConfig,
                              groupSeparatorBuilder:
                                  chatBackgroundConfig.groupSeparatorBuilder,
                            ),
                            indexedItemBuilder: (context, message, index) {
                              return ChatBubbleWidget(
                                key: message.key,
                                chatController: chatController,
                                messageTimeTextStyle:
                                    chatBackgroundConfig.messageTimeTextStyle,
                                messageTimeIconColor:
                                    chatBackgroundConfig.messageTimeIconColor,
                                message: message,
                                showReceiverProfileCircle:
                                    widget.showReceiverProfileCircle,
                                messageConfig: widget.messageConfig,
                                chatBubbleConfig: chatBubbleConfig,
                                profileCircleConfig: profileCircleConfig,
                                swipeToReplyConfig: widget.swipeToReplyConfig,
                                repliedMessageConfig:
                                    widget.repliedMessageConfig,
                                horizontalDragToShowTime:
                                    horizontalDragToShowTime,
                                slideAnimation: _slideAnimation,
                                onLongPress: (yCoordinate, xCoordinate) =>
                                    widget.onChatBubbleLongPress(
                                  yCoordinate,
                                  xCoordinate,
                                  message,
                                ),
                                onSwipe: widget.assignReplyMessage,
                                currentUser: widget.currentUser,
                                shouldHighlight: _replyId == message.id,
                                onReplyTap: widget
                                            .repliedMessageConfig
                                            ?.repliedMsgAutoScrollConfig
                                            .enableScrollToRepliedMsg ??
                                        false
                                    ? (replyId) =>
                                        _onReplyTap(replyId, snapshot.data)
                                    : null,
                              );
                            },
                          )
                        : Center(
                            child: chatBackgroundConfig.loadingWidget ??
                                const CircularProgressIndicator(),
                          );
                  },
                );
              },
            ),
          ),
          TypingIndicator(
            typeIndicatorConfig: widget.typeIndicatorConfig,
            chatBubbleConfig: chatBubbleConfig?.inComingChatBubbleConfig,
            showIndicator: showTypingIndicator,
            profilePic: profileCircleConfig?.profileImageUrl,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width *
                (widget.replyMessage.message.isNotEmpty ? 0.3 : 0.14),
          ),
        ],
      ),
    );
  }

  Future<void> _onReplyTap(String id, List<Message>? messages) async {
    // Finds the replied message if exists
    final repliedMessages = messages?.firstWhere((message) => id == message.id);

    // Scrolls to replied message and highlights
    if (repliedMessages != null && repliedMessages.key.currentState != null) {
      await Scrollable.ensureVisible(
        repliedMessages.key.currentState!.context,
        // This value will make widget to be in center when auto scrolled.
        alignment: 0.5,
        curve: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
                .highlightScrollCurve ??
            Curves.easeIn,
        duration: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
                .highlightDuration ??
            const Duration(milliseconds: 300),
      );
      if (widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
              .enableHighlightRepliedMsg ??
          false) {
        _replyId = id;
        if (mounted) setState(() {});

        Future.delayed(
          widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
                  .highlightDuration ??
              const Duration(milliseconds: 300),
          () {
            _replyId = null;
            if (mounted) setState(() {});
          },
        );
      }
    }
  }

  void _onHorizontalDrag(DragUpdateDetails details) {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(
      CurvedAnimation(
        curve: chatBackgroundConfig.messageTimeAnimationCurve,
        parent: _animationController,
      ),
    );

    details.delta.dx > 1
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _GroupSeparatorBuilder extends StatelessWidget {
  const _GroupSeparatorBuilder({
    Key? key,
    required this.separator,
    this.groupSeparatorBuilder,
    this.defaultGroupSeparatorConfig,
  }) : super(key: key);
  final String separator;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;

  @override
  Widget build(BuildContext context) {
    return groupSeparatorBuilder != null
        ? groupSeparatorBuilder!(separator)
        : ChatGroupHeader(
            day: DateTime.parse(separator),
            groupSeparatorConfig: defaultGroupSeparatorConfig,
          );
  }
}
