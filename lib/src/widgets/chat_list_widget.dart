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

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({
    Key? key,
    required this.chatController,
    required this.chatBackgroundConfig,
    required this.showTypingIndicator,
    required this.assignReplyMessage,
    required this.replyMessage,
    required this.focusNode,
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

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration for background of chat.
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides flag for turn on/off typing indicator.
  final bool showTypingIndicator;

  /// Provides configuration for reaction pop up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Provides configuration for customisation of different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Provides configuration of chat bubble's appearance.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Provides configuration for profile circle avatar of user.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configuration for when user swipe to chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides configuration for replied message view which is located upon chat
  /// bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configuration of typing indicator's appearance.
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides reply message when user swipe to chat bubble.
  final Message? replyMessage;

  /// Provides configuration for reply snack bar's appearance and options.
  final ReplyPopupConfiguration? replyPopupConfig;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides callback for assigning reply message when user swipe to chat
  /// bubble.
  final MessageCallBack assignReplyMessage;

  final FocusNode focusNode;

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> showPopUp = ValueNotifier(false);

  final GlobalKey<ReactionPopupState> _reactionPopupKey = GlobalKey();

  ChatController get chatController => widget.chatController;

  List<ValueNotifier<Message>> get messageList =>
      chatController.initialMessageList;

  AutoScrollController get scrollController => chatController.scrollController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  FeatureActiveConfig? featureActiveConfig;

  ChatUser? currentUser;

  bool isCupertino = false;

  @override
  void initState() {
    super.initState();
    _initialize();
    // scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // if (scrollController.offset >=
    //     scrollController.position.maxScrollExtent - 10) {
    //   if (!chatController._isNextPageLoadingNotifier.value) {
    //     chatController._isNextPageLoadingNotifier.value = true;

    //     // TODO: Change the logic and make indicator bigger as far as user goes beyond maxScrollExtent
    //     /// utilise maxScrollExtent extentBefore and outOfRange properties from `ScrollController.position`
    //     // chatController._pagintationLoadMore().then(
    //     //     (value) => chatController._isNextPageLoadingNotifier.value = false);
    //   }
    // } else {
    //   chatController._isNextPageLoadingNotifier.value = false;
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      featureActiveConfig = provide!.featureActiveConfig;
      currentUser = provide!.currentUser;
      showPopUp = provide!.chatController.showPopUp;
      isCupertino = provide!.isCupertinoApp;
    }

    if (featureActiveConfig?.enablePagination ?? false) {
      // When flag is on then it will include pagination logic to scroll
      // controller.
      // _pagination();
    }
  }

  void _initialize() {
    chatController.messageStreamController = StreamController();
    if (!chatController.messageStreamController.isClosed) {
      chatController.messageStreamController.sink.add(messageList);
    }

    // if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ChatGroupedListWidget(
                showPopUp: showPopUp.value,
                // reactionPopupConfig: widget.reactionPopupConfig,
                showTypingIndicator: showTypingIndicator,
                scrollController: scrollController,
                isEnableSwipeToSeeTime:
                    featureActiveConfig?.enableSwipeToSeeTime ?? true,
                chatBackgroundConfig: widget.chatBackgroundConfig,
                assignReplyMessage: widget.assignReplyMessage,
                replyMessage: widget.replyMessage,
                swipeToReplyConfig: widget.swipeToReplyConfig,
                repliedMessageConfig: widget.repliedMessageConfig,
                profileCircleConfig: widget.profileCircleConfig,
                messageConfig: widget.messageConfig,
                chatBubbleConfig: widget.chatBubbleConfig,
                typeIndicatorConfig: widget.typeIndicatorConfig,
                onChatBubbleLongPress: (yCoordinate, xCoordinate, message) {
                  if (!isCupertino) {
                    chatController.showMessageActions.value = message;

                    if (featureActiveConfig?.enableReactionPopup ?? false) {
                      _reactionPopupKey.currentState?.refreshWidget(
                        message: message,
                        xCoordinate: xCoordinate,
                        yCoordinate:
                            yCoordinate < 0 ? -(yCoordinate) - 5 : yCoordinate,
                      );
                      showPopUp.value = true;
                    }
                    if (featureActiveConfig?.enableReplySnackBar ?? false) {
                      _showReplyPopup(
                        message: message,
                        sendByCurrentUser: message.author.id == currentUser?.id,
                      );
                    }
                  }
                },
                onChatListTap: _onChatListTap,
              ),
              if (featureActiveConfig?.enableReactionPopup ?? false) ...[
                ValueListenableBuilder<bool>(
                    valueListenable: showPopUp,
                    builder: (_, showPopupValue, child) {
                      if (!showPopupValue) {
                        if (!isCupertino) {
                          Future.delayed(const Duration(milliseconds: 0), () {
                            chatController.showMessageActions.value = null;
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }
                      }

                      return ReactionPopup(
                        key: _reactionPopupKey,
                        reactionPopupConfig: widget.reactionPopupConfig,
                        onTap: _onChatListTap,
                        showPopUp: showPopupValue,
                      );
                    })
              ]
            ],
          ),
        ),
      ],
    );
  }

  void _pagination() {
    // if (widget.loadMoreData == null || widget.isLastPage == true) return;
    scrollController.addListener(() {
      print(scrollController.position);
    });
  }

  void _showReplyPopup({
    required Message message,
    required bool sendByCurrentUser,
  }) {
    final replyPopup = widget.replyPopupConfig;
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
                      if (featureActiveConfig?.enableReactionPopup ?? false) {
                        showPopUp.value = false;
                      }
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
    showPopUp.value = false;
    //TODO: Conditional when non cupertinoApp
    if (!isCupertino) {
      ChatViewInheritedWidget.of(context)!
          .chatController
          .showMessageActions
          .value = null;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  @override
  void dispose() {
    chatController.messageStreamController.close();
    // scrollController.dispose();
    chatController._isNextPageLoadingNotifier.dispose();
    showPopUp.dispose();
    super.dispose();
  }
}
