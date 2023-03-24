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
import 'dart:io' if (kIsWeb) 'dart:html';

import 'package:chatview/src/extensions/extensions.dart';
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
    required this.showTypingIndicator,
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
  final ReplyMessage replyMessage;

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

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _isNextPageLoading = ValueNotifier(false);
  ValueNotifier<bool> showPopUp = ValueNotifier(false);
  final GlobalKey<ReactionPopupState> _reactionPopupKey = GlobalKey();

  ChatController get chatController => widget.chatController;

  List<Message> get messageList => chatController.initialMessageList;

  ScrollController get scrollController => chatController.scrollController;

  bool get showTypingIndicator => widget.showTypingIndicator;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  FeatureActiveConfig? featureActiveConfig;
  ChatUser? currentUser;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      featureActiveConfig = provide!.featureActiveConfig;
      currentUser = provide!.currentUser;
    }
    if (featureActiveConfig?.enablePagination ?? false) {
      // When flag is on then it will include pagination logic to scroll
      // controller.
      scrollController.addListener(_pagination);
    }
  }

  void _initialize() {
    chatController.messageStreamController = StreamController();
    if (!chatController.messageStreamController.isClosed) {
      chatController.messageStreamController.sink.add(messageList);
    }
    if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isNextPageLoading,
          builder: (_, isNextPageLoading, child) {
            if (isNextPageLoading &&
                (featureActiveConfig?.enablePagination ?? false)) {
              return SizedBox(
                height: Scaffold.of(context).appBarMaxHeight,
                child: Center(
                  child:
                      widget.loadingWidget ?? const CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: showPopUp,
            builder: (_, showPopupValue, child) {
              return Stack(
                children: [
                  ChatGroupedListWidget(
                    showPopUp: showPopupValue,
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
                      if (featureActiveConfig?.enableReactionPopup ?? false) {
                        _reactionPopupKey.currentState?.refreshWidget(
                          message: message,
                          xCoordinate: xCoordinate,
                          yCoordinate: yCoordinate < 0
                              ? -(yCoordinate) - 5
                              : yCoordinate,
                        );
                        showPopUp.value = true;
                      }
                      if (featureActiveConfig?.enableReplySnackBar ?? false) {
                        _showReplyPopup(
                          message: message,
                          sendByCurrentUser: message.sendBy == currentUser?.id,
                        );
                      }
                    },
                    onChatListTap: _onChatListTap,
                  ),
                  if (featureActiveConfig?.enableReactionPopup ?? false)
                    ReactionPopup(
                      key: _reactionPopupKey,
                      reactionPopupConfig: widget.reactionPopupConfig,
                      onTap: _onChatListTap,
                      showPopUp: showPopupValue,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _pagination() {
    if (widget.loadMoreData == null || widget.isLastPage == true) return;
    if ((scrollController.position.pixels ==
            scrollController.position.minScrollExtent) &&
        !_isNextPageLoading.value) {
      _isNextPageLoading.value = true;
      widget.loadMoreData!()
          .whenComplete(() => _isNextPageLoading.value = false);
    }
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
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void dispose() {
    chatController.messageStreamController.close();
    scrollController.dispose();
    _isNextPageLoading.dispose();
    showPopUp.dispose();
    super.dispose();
  }
}
