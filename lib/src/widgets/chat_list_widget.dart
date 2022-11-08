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

import 'package:chatview/src/widgets/chat_groupedlist_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../chatview.dart';
import 'reaction_popup.dart';
import 'reply_popup_widget.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({
    Key? key,
    required this.chatController,
    required this.chatBackgroundConfig,
    required this.enablePagination,
    required this.sender,
    required this.receiver,
    required this.showTypingIndicator,
    required this.showReceiverProfileCircle,
    required this.assignReplyMessage,
    required this.replyMessage,
    this.loadingWidget,
    this.reactionPopupConfig,
    this.messageConfig,
    this.chatBubbleConfig,
    this.profileCircleConfig,
    this.swipeToReplyConfig,
    this.repliedMessageConfig,
    this.typeIndicatorConfig,
    this.replyPopupConfig,
    this.loadMoreData,
    this.isLastPage,
  }) : super(key: key);
  final ChatController chatController;
  final ChatBackgroundConfiguration chatBackgroundConfig;
  final bool enablePagination;
  final Widget? loadingWidget;
  final bool showTypingIndicator;
  final ReactionPopupConfiguration? reactionPopupConfig;
  final bool showReceiverProfileCircle;
  final MessageConfiguration? messageConfig;
  final ChatBubbleConfiguration? chatBubbleConfig;
  final ProfileCircleConfiguration? profileCircleConfig;
  final SwipeToReplyConfiguration? swipeToReplyConfig;
  final RepliedMessageConfiguration? repliedMessageConfig;
  final ChatUser sender;
  final ChatUser receiver;
  final TypeIndicatorConfiguration? typeIndicatorConfig;
  final ReplyMessage replyMessage;
  final ReplyPopupConfiguration? replyPopupConfig;
  final VoidCallBackWithFuture? loadMoreData;
  final bool? isLastPage;
  final MessageCallBack assignReplyMessage;

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget>
    with SingleTickerProviderStateMixin {
  bool _isNextPageLoading = false;
  bool showPopUp = false;
  final GlobalKey<ReactionPopupState> _reactionPopupKey = GlobalKey();

  ChatController get chatController => widget.chatController;

  List<Message> get messageList => chatController.initialMessageList;

  ScrollController get scrollController => chatController.scrollController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  bool get horizontalDragToShowTime =>
      chatBackgroundConfig.horizontalDragToShowMessageTime;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    chatController.messageStreamController.sink.add(messageList);
    if (widget.enablePagination) {
      scrollController.addListener(_pagination);
    }
    if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    final reactionPopup = ReactionPopup(
      key: _reactionPopupKey,
      reactionPopupConfig: widget.reactionPopupConfig,
      onTap: _onChatListTap,
      showPopUp: showPopUp,
    );
    return messageList.isNotEmpty
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
                    ChatGroupedListWidget(
                      showPopUp: showPopUp,
                      showTypingIndicator: showTypingIndicator,
                      scrollController: scrollController,
                      chatController: chatController,
                      sender: widget.sender,
                      chatBackgroundConfig: widget.chatBackgroundConfig,
                      assignReplyMessage: widget.assignReplyMessage,
                      showReceiverProfileCircle:
                          widget.showReceiverProfileCircle,
                      replyMessage: widget.replyMessage,
                      receiver: widget.receiver,
                      swipeToReplyConfig: widget.swipeToReplyConfig,
                      repliedMessageConfig: widget.repliedMessageConfig,
                      profileCircleConfig: widget.profileCircleConfig,
                      messageConfig: widget.messageConfig,
                      chatBubbleConfig: widget.chatBubbleConfig,
                      typeIndicatorConfig: widget.typeIndicatorConfig,
                      onChatBubbleLongPress:
                          (yCoordinate, xCoordinate, message) {
                        _reactionPopupKey.currentState?.refreshWidget(
                          messageId: message.id,
                          xCoordinate: xCoordinate,
                          yCoordinate: yCoordinate < 0
                              ? -(yCoordinate) - 5
                              : yCoordinate,
                        );
                        _showReplyPopup(
                          message: message,
                          sendByCurrentUser: message.sendBy == widget.sender.id,
                        );
                      },
                      onChatListTap: _onChatListTap,
                    ),
                    reactionPopup,
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
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
                      _onChatListTap();
                      if (replyPopup?.onMoreTap != null) {
                        replyPopup?.onMoreTap!();
                      }
                    },
                    onReportTap: () {
                      _onChatListTap();
                      if (replyPopup?.onReportTap != null) {
                        replyPopup?.onReportTap!();
                      }
                    },
                    onUnsendTap: () {
                      _onChatListTap();
                      if (replyPopup?.onUnsendTap != null) {
                        replyPopup?.onUnsendTap!(message);
                      }
                    },
                    onReplyTap: () {
                      widget.assignReplyMessage(message);
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

  void _onChatListTap() {
    if (!kIsWeb && Platform.isIOS) FocusScope.of(context).unfocus();
    setState(() => showPopUp = false);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void dispose() {
    chatController.messageStreamController.close();
    super.dispose();
  }
}
