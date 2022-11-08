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
import 'package:chatview/src/widgets/chat_list_widget.dart';

import 'package:flutter/material.dart';

import 'send_message_widget.dart';

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
  final GlobalKey<SendMessageWidgetState> _sendMessageKey = GlobalKey();
  ReplyMessage replyMessage = ReplyMessage();

  ChatController get chatController => widget.chatController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  @override
  Widget build(BuildContext context) {
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
                ChatListWidget(
                  sender: widget.sender,
                  showTypingIndicator: widget.showTypingIndicator,
                  receiver: widget.receiver,
                  enablePagination: widget.enablePagination,
                  showReceiverProfileCircle: widget.showReceiverProfileCircle,
                  replyMessage: replyMessage,
                  chatController: widget.chatController,
                  chatBackgroundConfig: widget.chatBackgroundConfig,
                  reactionPopupConfig: widget.reactionPopupConfig,
                  typeIndicatorConfig: widget.typeIndicatorConfig,
                  chatBubbleConfig: widget.chatBubbleConfig,
                  loadMoreData: widget.loadMoreData,
                  isLastPage: widget.isLastPage,
                  replyPopupConfig: widget.replyPopupConfig,
                  loadingWidget: widget.loadingWidget,
                  messageConfig: widget.messageConfig,
                  profileCircleConfig: widget.profileCircleConfig,
                  repliedMessageConfig: widget.repliedMessageConfig,
                  swipeToReplyConfig: widget.swipeToReplyConfig,
                  assignReplyMessage: (message) =>
                      _sendMessageKey.currentState?.assignReplyMessage(message),
                ),
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
}
