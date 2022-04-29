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
import 'dart:io' if (kIsWeb) 'dart:html';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

import 'package:grouped_list/grouped_list.dart';

import 'package:chatview/src/extensions/extensions.dart';
import 'chat_group_header.dart';
import 'chat_bubble_widget.dart';
import 'reaction_popup.dart';
import 'reply_popup_widget.dart';
import 'send_message_widget.dart';
import 'type_indicator_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.sender,
    required this.receiver,
    required this.chatController,
    this.onSendTap,
    this.showReceiverProfileCircle = true,
    this.enablePagination = false,
    this.profileCircleConfig,
    this.chatBubbleConfig,
    this.repliedMessageConfig,
    this.swipeToReplyConfig,
    this.replyPopupConfig,
    this.reactionPopupConfig,
    this.loadMoreData,
    this.loadingWidget,
    this.messageConfig,
    this.isLastPage,
    this.appBar,
    ChatBackgroundConfiguration? chatBackgroundConfig,
    this.typeIndicatorConfig,
    this.sendMessageBuilder,
    this.showTypingIndicator = false,
    this.sendMessageConfig,
  })  : chatBackgroundConfig =
            chatBackgroundConfig ?? const ChatBackgroundConfiguration(),
        super(key: key);

  final ProfileCircleConfiguration? profileCircleConfig;
  final bool showReceiverProfileCircle;
  final ChatBubbleConfiguration? chatBubbleConfig;
  final MessageConfiguration? messageConfig;
  final RepliedMessageConfiguration? repliedMessageConfig;
  final SwipeToReplyConfiguration? swipeToReplyConfig;
  final ReplyPopupConfiguration? replyPopupConfig;
  final ReactionPopupConfiguration? reactionPopupConfig;
  final ChatBackgroundConfiguration chatBackgroundConfig;
  final VoidCallBackWithFuture? loadMoreData;
  final bool enablePagination;
  final Widget? loadingWidget;
  final bool? isLastPage;
  final ChatUser sender;
  final ChatUser receiver;
  final StringMessageCallBack? onSendTap;
  final ReplyMessageWithReturnWidget? sendMessageBuilder;
  final bool showTypingIndicator;
  final TypeIndicatorConfiguration? typeIndicatorConfig;
  final ChatController chatController;
  final SendMessageConfiguration? sendMessageConfig;

  final Widget? appBar;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isNextPageLoading = false;
  final GlobalKey<ReactionPopupState> _reactionPopupKey = GlobalKey();
  final GlobalKey<SendMessageWidgetState> _sendMessageKey = GlobalKey();
  bool showPopUp = false;
  ReplyMessage replyMessage = ReplyMessage();

  ChatController get chatController => widget.chatController;

  List<Message> get messageList => chatController.initialMessageList;

  ScrollController get scrollController => chatController.scrollController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    chatController.messageStreamController.sink.add(messageList);
    if (widget.chatBackgroundConfig.horizontalDragToShowMessageTime) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
      );
      _slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(
        curve: Curves.decelerate,
        parent: _animationController,
      ));
    }
    if (widget.enablePagination) {
      scrollController.addListener(_pagination);
    }
    if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    ReactionPopup reactionPopup = ReactionPopup(
      key: _reactionPopupKey,
      reactionPopupConfig: widget.reactionPopupConfig,
      onTap: _onTap,
      showPopUp: showPopUp,
    );
    final horizontalDragToShowTime =
        chatBackgroundConfig.horizontalDragToShowMessageTime;
    if (showTypingIndicator) chatController.scrollToLastMessage();
    return Container(
      height: chatBackgroundConfig.height ?? MediaQuery.of(context).size.height,
      width: chatBackgroundConfig.width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: chatBackgroundConfig.backgroundColor ?? Colors.white,
        image: chatBackgroundConfig.backgroundImage != null
            ? DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(chatBackgroundConfig.backgroundImage!),
              )
            : null,
      ),
      padding: chatBackgroundConfig.padding,
      margin: chatBackgroundConfig.margin,
      child: Column(
        children: [
          if (widget.appBar != null) widget.appBar!,
          Expanded(
            child: Stack(
              children: [
                messageList.isNotEmpty
                    ? Column(
                        children: [
                          if (_isNextPageLoading && widget.enablePagination)
                            SizedBox(
                              height: Scaffold.of(context).appBarMaxHeight,
                              child: Center(
                                child: widget.loadingWidget ??
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  reverse: true,
                                  physics: showPopUp
                                      ? const NeverScrollableScrollPhysics()
                                      : null,
                                  padding: EdgeInsets.only(
                                      bottom: showTypingIndicator ? 50 : 0),
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onHorizontalDragUpdate: (details) =>
                                            horizontalDragToShowTime
                                                ? showPopUp
                                                    ? null
                                                    : _onHorizontalDrag(details)
                                                : null,
                                        onHorizontalDragEnd: (details) =>
                                            horizontalDragToShowTime
                                                ? showPopUp
                                                    ? null
                                                    : _animationController
                                                        .reverse()
                                                : null,
                                        onTap: _onTap,
                                        child: AnimatedBuilder(
                                          animation: _animationController,
                                          builder: (context, child) {
                                            return StreamBuilder<List<Message>>(
                                              stream: chatController
                                                  .messageStreamController
                                                  .stream,
                                              builder: (context, snapshot) {
                                                return snapshot.connectionState
                                                        .isActive
                                                    ? GroupedListView<Message,
                                                        String>(
                                                        shrinkWrap: true,
                                                        elements:
                                                            snapshot.data!,
                                                        groupBy: (element) =>
                                                            element.createdAt
                                                                .getDateFromDateTime,
                                                        itemComparator: (message1,
                                                                message2) =>
                                                            message1.message
                                                                .compareTo(
                                                                    message2
                                                                        .message),
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        order:
                                                            chatBackgroundConfig
                                                                .groupedListOrder,
                                                        sort:
                                                            chatBackgroundConfig
                                                                .sortEnable,
                                                        groupSeparatorBuilder: (separator) =>
                                                            chatBackgroundConfig
                                                                        .groupSeparatorBuilder !=
                                                                    null
                                                                ? chatBackgroundConfig
                                                                        .groupSeparatorBuilder!(
                                                                    separator)
                                                                : ChatGroupHeader(
                                                                    day: DateTime
                                                                        .parse(
                                                                            separator),
                                                                    groupSeparatorConfig:
                                                                        chatBackgroundConfig
                                                                            .defaultGroupSeparatorConfig,
                                                                  ),
                                                        indexedItemBuilder:
                                                            (context, message,
                                                                    index) =>
                                                                ChatBubbleWidget(
                                                          chatController:
                                                              chatController,
                                                          messageTimeTextStyle:
                                                              chatBackgroundConfig
                                                                  .messageTimeTextStyle,
                                                          messageTimeIconColor:
                                                              chatBackgroundConfig
                                                                  .messageTimeIconColor,
                                                          message: message,
                                                          showReceiverProfileCircle:
                                                              widget
                                                                  .showReceiverProfileCircle,
                                                          messageConfig: widget
                                                              .messageConfig,
                                                          chatBubbleConfig: widget
                                                              .chatBubbleConfig,
                                                          profileCircleConfig:
                                                              widget
                                                                  .profileCircleConfig,
                                                          swipeToReplyConfig: widget
                                                              .swipeToReplyConfig,
                                                          repliedMessageConfig:
                                                              widget
                                                                  .repliedMessageConfig,
                                                          horizontalDragToShowTime:
                                                              horizontalDragToShowTime,
                                                          slideAnimation:
                                                              _slideAnimation,
                                                          onLongPress:
                                                              (yCoordinate,
                                                                  xCoordinate) {
                                                            _reactionPopupKey
                                                                .currentState
                                                                ?.refreshWidget(
                                                              messageId:
                                                                  message.id,
                                                              xCoordinate:
                                                                  xCoordinate,
                                                              yCoordinate: yCoordinate <
                                                                      0
                                                                  ? -(yCoordinate) -
                                                                      5
                                                                  : yCoordinate,
                                                            );
                                                            _showReplyPopup(
                                                              message: message,
                                                              sendByCurrentUser:
                                                                  message.sendBy ==
                                                                      widget
                                                                          .sender
                                                                          .id,
                                                            );
                                                          },
                                                          onSwipe: (message) =>
                                                              _sendMessageKey
                                                                  .currentState
                                                                  ?.assignReplyMessage(
                                                                      message),
                                                          receiver:
                                                              widget.receiver,
                                                          sender: widget.sender,
                                                        ),
                                                      )
                                                    : Center(
                                                        child: chatBackgroundConfig
                                                                .loadingWidget ??
                                                            const CircularProgressIndicator(),
                                                      );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      TypingIndicator(
                                        typeIndicatorConfig:
                                            widget.typeIndicatorConfig,
                                        chatBubbleConfig: widget
                                            .chatBubbleConfig
                                            ?.inComingChatBubbleConfig,
                                        showIndicator: showTypingIndicator,
                                        profilePic: widget.profileCircleConfig
                                            ?.profileImageUrl,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                (replyMessage.message.isNotEmpty
                                                    ? 0.3
                                                    : 0.14),
                                      ),
                                    ],
                                  ),
                                ),
                                reactionPopup,
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                SendMessageWidget(
                  key: _sendMessageKey,
                  sendMessageBuilder: widget.sendMessageBuilder,
                  sendMessageConfig: widget.sendMessageConfig,
                  backgroundColor: chatBackgroundConfig.backgroundColor,
                  onSendTap: _onSendTap,
                  receiver: widget.receiver,
                  sender: widget.sender,
                  onReplyCallback: (reply) =>
                      setState(() => replyMessage = reply),
                  onReplyCloseCallback: () =>
                      setState(() => replyMessage = ReplyMessage()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSendTap(String message, ReplyMessage replyMessage) {
    if (widget.sendMessageBuilder == null) {
      if (widget.onSendTap != null) {
        widget.onSendTap!(message.trim(), replyMessage);
      }
      _assignReplyMessage();
    }
    chatController.scrollToLastMessage();
  }

  void _assignReplyMessage() {
    if (replyMessage.message.isNotEmpty) {
      setState(() => replyMessage = ReplyMessage());
    }
  }

  void _onTap() {
    if (!kIsWeb && Platform.isIOS) FocusScope.of(context).unfocus();
    setState(() => showPopUp = false);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void _onHorizontalDrag(DragUpdateDetails details) {
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
        .animate(CurvedAnimation(
            curve: Curves.decelerate, parent: _animationController));

    details.delta.dx > 1
        ? _animationController.reverse()
        : _animationController.forward();
  }

  void _showReplyPopup({
    required Message message,
    required bool sendByCurrentUser,
  }) {
    final replyPopup = widget.replyPopupConfig;
    setState(() => showPopUp = true);
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(hours: 1),
            backgroundColor: replyPopup?.backgroundColor ?? Colors.white,
            content: replyPopup?.replyPopupBuilder != null
                ? replyPopup!.replyPopupBuilder!(message, sendByCurrentUser)
                : ReplyPopupWidget(
                    buttonTextStyle: replyPopup?.buttonTextStyle,
                    topBorderColor: replyPopup?.topBorderColor,
                    onMoreTap: () {
                      _onTap();
                      if (replyPopup?.onMoreTap != null) {
                        replyPopup?.onMoreTap!();
                      }
                    },
                    onReportTap: () {
                      _onTap();
                      if (replyPopup?.onReportTap != null) {
                        replyPopup?.onReportTap!();
                      }
                    },
                    onUnsendTap: () {
                      _onTap();
                      if (replyPopup?.onUnsendTap != null) {
                        replyPopup?.onUnsendTap!(message);
                      }
                    },
                    onReplyTap: () {
                      _sendMessageKey.currentState?.assignReplyMessage(message);
                      setState(() => showPopUp = false);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (replyPopup?.onReplyTap != null) {
                        replyPopup?.onReplyTap!(message);
                      }
                    },
                    sendByCurrentUser: sendByCurrentUser,
                  ),
            padding: EdgeInsets.zero,
          ),
        )
        .closed;
  }

  void _pagination() {
    if (widget.loadMoreData == null || widget.isLastPage == true) return;
    if ((scrollController.position.pixels ==
            scrollController.position.minScrollExtent) &&
        !_isNextPageLoading) {
      setState(() => _isNextPageLoading = true);
      widget.loadMoreData!()
          .whenComplete(() => setState(() => _isNextPageLoading = false));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    chatController.messageStreamController.close();
    super.dispose();
  }
}
