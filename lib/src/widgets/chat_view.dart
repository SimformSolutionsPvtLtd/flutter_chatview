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
import 'package:chatview/src/widgets/chatview_state_widget.dart';
import 'package:chatview/src/widgets/chat_view_inherited_widget.dart';

import 'package:flutter/material.dart';

import 'send_message_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.chatController,
    required this.currentUser,
    this.onSendTap,
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
    required this.chatViewState,
    ChatViewStateConfiguration? chatViewStateConfig,
    this.featureActiveConfig = const FeatureActiveConfig(),
  })  : chatBackgroundConfig =
            chatBackgroundConfig ?? const ChatBackgroundConfiguration(),
        chatViewStateConfig =
            chatViewStateConfig ?? const ChatViewStateConfiguration(),
        super(key: key);

  /// Provides configuration related to user profile circle avatar.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configurations related to chat bubble such as padding, margin, max
  /// width etc.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Allow user to giving customisation different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Provides configuration for replied message view which is located upon chat
  /// bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configurations related to swipe chat bubble which triggers
  /// when user swipe chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides configuration for reply snack bar's appearance and options.
  final ReplyPopupConfiguration? replyPopupConfig;

  /// Provides configuration for reaction pop up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Allow user to give customisation to background of chat
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides call back when user tap on send button in text field. It returns
  /// message, reply message and message type.
  final StringMessageCallBack? onSendTap;

  /// Provides builder which helps you to make custom text field and functionality.
  final ReplyMessageWithReturnWidget? sendMessageBuilder;

  /// Allow user to show typing indicator.
  final bool showTypingIndicator;

  /// Allow user to giving customisation typing indicator.
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration? sendMessageConfig;

  /// Provides current state of chat.
  final ChatViewState chatViewState;

  /// Provides configuration for chat view state appearance and functionality.
  final ChatViewStateConfiguration? chatViewStateConfig;

  /// Provides current user which is sending messages.
  final ChatUser currentUser;

  /// Provides configuration for turn on/off specific features.
  final FeatureActiveConfig featureActiveConfig;

  /// Provides parameter so user can assign ChatViewAppbar.
  final Widget? appBar;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SendMessageWidgetState> _sendMessageKey = GlobalKey();
  ReplyMessage replyMessage = const ReplyMessage();

  ChatController get chatController => widget.chatController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  ChatViewState get chatViewState => widget.chatViewState;

  ChatViewStateConfiguration? get chatViewStateConfig =>
      widget.chatViewStateConfig;

  FeatureActiveConfig get featureActiveConfig => widget.featureActiveConfig;

  @override
  void initState() {
    super.initState();
    // Adds current user in users list.
    chatController.chatUsers.add(widget.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    // Scroll to last message on in hasMessages state.
    if (showTypingIndicator && chatViewState.hasMessages) {
      chatController.scrollToLastMessage();
    }
    return ChatViewInheritedWidget(
      chatController: chatController,
      featureActiveConfig: featureActiveConfig,
      currentUser: widget.currentUser,
      child: Container(
        height:
            chatBackgroundConfig.height ?? MediaQuery.of(context).size.height,
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
                  if (chatViewState.isLoading)
                    ChatViewStateWidget(
                      chatViewStateWidgetConfig:
                          chatViewStateConfig?.loadingWidgetConfig,
                      chatViewState: chatViewState,
                    )
                  else if (chatViewState.noMessages)
                    ChatViewStateWidget(
                      chatViewStateWidgetConfig:
                          chatViewStateConfig?.noMessageWidgetConfig,
                      chatViewState: chatViewState,
                      onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
                    )
                  else if (chatViewState.isError)
                    ChatViewStateWidget(
                      chatViewStateWidgetConfig:
                          chatViewStateConfig?.errorWidgetConfig,
                      chatViewState: chatViewState,
                      onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
                    )
                  else if (chatViewState.hasMessages)
                    ChatListWidget(
                      showTypingIndicator: widget.showTypingIndicator,
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
                      assignReplyMessage: (message) => _sendMessageKey
                          .currentState
                          ?.assignReplyMessage(message),
                    ),
                  if (featureActiveConfig.enableTextField)
                    SendMessageWidget(
                      key: _sendMessageKey,
                      chatController: chatController,
                      sendMessageBuilder: widget.sendMessageBuilder,
                      sendMessageConfig: widget.sendMessageConfig,
                      backgroundColor: chatBackgroundConfig.backgroundColor,
                      onSendTap: _onSendTap,
                      onReplyCallback: (reply) =>
                          setState(() => replyMessage = reply),
                      onReplyCloseCallback: () =>
                          setState(() => replyMessage = const ReplyMessage()),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    if (widget.sendMessageBuilder == null) {
      if (widget.onSendTap != null) {
        widget.onSendTap!(message, replyMessage, messageType);
      }
      _assignReplyMessage();
    }
    chatController.scrollToLastMessage();
  }

  void _assignReplyMessage() {
    if (replyMessage.message.isNotEmpty) {
      setState(() => replyMessage = const ReplyMessage());
    }
  }
}
