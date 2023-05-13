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

part of '../../chatview.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.chatController,
    required this.currentUser,
    this.isCupertinoApp = false,
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
    this.cupertinoWidgetConfig,
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

  @Deprecated('Use [ChatController.setTypingIndicator]  instead')

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

  final bool isCupertinoApp;

  final CupertinoWidgetConfiguration? cupertinoWidgetConfig;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  ValueNotifier<Message?> replyMessageNotifier = ValueNotifier(null);

  ValueNotifier<Message?> replyMessage = ValueNotifier(null);

  ChatController get chatController => widget.chatController;

  // bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  ChatViewState get chatViewState => widget.chatViewState;

  ChatViewStateConfiguration? get chatViewStateConfig =>
      widget.chatViewStateConfig;

  FeatureActiveConfig get featureActiveConfig => widget.featureActiveConfig;

  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    setLocaleMessages('en', ReceiptsCustomMessages());
    focusNode = FocusNode();
    // Adds current user in users list.
    chatController.chatUsers.add(widget.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    // Scroll to last message on in hasMessages state.
    // TODO: Remove this in new versions.
    // ignore: deprecated_member_use_from_same_package
    if (widget.showTypingIndicator ||
        widget.chatController.showTypingIndicator &&
            chatViewState.hasMessages) {
      chatController.scrollToLastMessage();
    }
    return ChatViewInheritedWidget(
      isCupertinoApp: widget.isCupertinoApp,
      chatController: chatController,
      cupertinoWidgetConfig: widget.cupertinoWidgetConfig,
      featureActiveConfig: featureActiveConfig,
      currentUser: widget.currentUser,
      child: MaterialConditionalWrapper(
          condition: widget.isCupertinoApp,
          child: Stack(children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.appBar != null) widget.appBar!,
                Flexible(
                  child: getWidget(),
                ),
                // widget.showTypingIndicator
                //     ? TypingIndicator(
                //         typeIndicatorConfig: widget.typeIndicatorConfig,
                //         chatBubbleConfig:
                //             widget.chatBubbleConfig?.inComingChatBubbleConfig,
                //         showIndicator: widget.showTypingIndicator,
                //         profilePic: widget.profileCircleConfig?.profileImageUrl,
                //       )
                //     : ValueListenableBuilder(
                //         valueListenable:
                //             widget.chatController.typingIndicatorNotifier,
                //         builder: (context, value, child) => TypingIndicator(
                //               typeIndicatorConfig: widget.typeIndicatorConfig,
                //               chatBubbleConfig: widget
                //                   .chatBubbleConfig?.inComingChatBubbleConfig,
                //               showIndicator: value,
                //               profilePic:
                //                   widget.profileCircleConfig?.profileImageUrl,
                //             )),
                if (featureActiveConfig.enableTextField)
                  SendMessageWidget(
                    replyMessageNotfier: replyMessageNotifier,
                    chatController: chatController,
                    sendMessageBuilder: widget.sendMessageBuilder,
                    sendMessageConfig: widget.sendMessageConfig,
                    backgroundColor: chatBackgroundConfig.backgroundColor,
                    onSendTap: _onSendTap,
                    onReplyCallback: (reply) => replyMessage.value = reply,
                    onReplyCloseCallback: () => replyMessage.value = null,
                  ),
              ],
            )
          ])),
    );
  }

  void _onSendTap(
      String message, Message? replyMessage, MessageType messageType,
      {Duration? duration}) {
    if (widget.sendMessageBuilder == null) {
      if (widget.onSendTap != null) {
        widget.onSendTap!(message, replyMessage, messageType,
            duration: duration);
      }
      _assignReplyMessage();
    }
    chatController.scrollToLastMessage();
  }

  Widget getWidget() {
    if (chatViewState.isLoading) {
      return ChatViewStateWidget(
        chatViewStateWidgetConfig: chatViewStateConfig?.loadingWidgetConfig,
        chatViewState: chatViewState,
      );
    } else if (chatViewState.noMessages) {
      return ChatViewStateWidget(
        chatViewStateWidgetConfig: chatViewStateConfig?.noMessageWidgetConfig,
        chatViewState: chatViewState,
        onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
      );
    } else if (chatViewState.isError) {
      return ChatViewStateWidget(
        chatViewStateWidgetConfig: chatViewStateConfig?.errorWidgetConfig,
        chatViewState: chatViewState,
        onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
      );
    } else if (chatViewState.hasMessages) {
      return ValueListenableBuilder<Message?>(
        valueListenable: replyMessage,
        builder: (_, state, child) {
          return ChatListWidget(

              /// TODO: Remove this in future releases.
              // ignore: deprecated_member_use_from_same_package
              showTypingIndicator: widget.showTypingIndicator,
              focusNode: focusNode,
              replyMessage: state,
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
              assignReplyMessage: (message) {
                replyMessageNotifier.value = message;
              });
        },
      );
    } else {
      return const SizedBox();
    }
  }

  void _assignReplyMessage() {
    if (replyMessage.value != null) {
      replyMessage.value = null;
    }
  }

  @override
  void dispose() {
    replyMessage.dispose();
    super.dispose();
  }
}
