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
import 'package:chatview/src/extensions/extensions.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:chatview/src/widgets/chat_view_inherited_widget.dart';
import 'package:chatview/src/widgets/multi_value_listenable_builder.dart';
import 'package:flutter/material.dart';

import '../../chatview.dart';
import 'message_time_widget.dart';
import 'message_view.dart';
import 'profile_circle.dart';
import 'reply_message_widget.dart';
import 'swipe_to_reply.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({
    required GlobalKey key,
    required this.message,
    required this.onLongPress,
    required this.slideAnimation,
    required this.onSwipe,
    this.onReplyTap,
    this.shouldHighlight = false,
  }) : super(key: key);

  /// Represent current instance of message.
  final Message message;

  /// Give callback once user long press on chat bubble.
  final DoubleCallBack onLongPress;

  /// Provides callback of when user swipe chat bubble for reply.
  final MessageCallBack onSwipe;

  /// Provides slide animation when user swipe whole chat.
  final Animation<Offset>? slideAnimation;

  /// Provides callback when user tap on replied message upon chat bubble.
  final Function(String)? onReplyTap;

  /// Flag for when user tap on replied message and highlight actual message.
  final bool shouldHighlight;

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  String get replyMessage => widget.message.replyMessage.message;

  bool get isMessageBySender => widget.message.sentBy == currentUser?.id;

  bool get isLastMessage =>
      chatController?.initialMessageList.last.id == widget.message.id;

  FeatureActiveConfig? featureActiveConfig;
  ChatController? chatController;
  ChatUser? currentUser;
  int? maxDuration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (chatViewIW != null) {
      featureActiveConfig = chatViewIW!.featureActiveConfig;
      chatController = chatViewIW!.chatController;
      currentUser = chatController?.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get user from id.
    final messagedUser = chatController?.getUserFromId(widget.message.sentBy);
    return Stack(
      children: [
        if (featureActiveConfig?.enableSwipeToSeeTime ?? true) ...[
          Visibility(
            visible: widget.slideAnimation?.value.dx == 0.0 ? false : true,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: MessageTimeWidget(
                  messageTime: widget.message.createdAt,
                  isCurrentUser: isMessageBySender,
                ),
              ),
            ),
          ),
          SlideTransition(
            position: widget.slideAnimation!,
            child: _chatBubbleWidget(messagedUser),
          ),
        ] else
          _chatBubbleWidget(messagedUser),
      ],
    );
  }

  Widget _chatBubbleWidget(ChatUser? messagedUser) {
    final chatBubbleConfig = chatListConfig.chatBubbleConfig;
    return Container(
      padding: chatBubbleConfig?.padding ?? const EdgeInsets.only(left: 5.0),
      margin: chatBubbleConfig?.margin ?? const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      alignment:
          isMessageBySender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isMessageBySender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMessageBySender &&
              (featureActiveConfig?.enableOtherUserProfileAvatar ?? true))
            profileCircle(messagedUser),
          _messagesWidgetColumn(messagedUser),
          if (isMessageBySender &&
              (featureActiveConfig?.enableCurrentUserProfileAvatar ?? true))
            profileCircle(messagedUser),
        ],
      ),
    );
  }

  ProfileCircle profileCircle(ChatUser? messagedUser) {
    final profileCircleConfig = chatListConfig.profileCircleConfig;
    return ProfileCircle(
      bottomPadding: widget.message.reaction.reactions.isNotEmpty
          ? profileCircleConfig?.bottomPadding ?? 15
          : profileCircleConfig?.bottomPadding ?? 2,
      profileCirclePadding: profileCircleConfig?.padding,
      imageUrl: messagedUser?.profilePhoto,
      imageType: messagedUser?.imageType,
      defaultAvatarImage: messagedUser?.defaultAvatarImage ?? profileImage,
      networkImageProgressIndicatorBuilder:
          messagedUser?.networkImageProgressIndicatorBuilder,
      assetImageErrorBuilder: messagedUser?.assetImageErrorBuilder,
      networkImageErrorBuilder: messagedUser?.networkImageErrorBuilder,
      circleRadius: profileCircleConfig?.circleRadius,
      onTap: () => _onAvatarTap(messagedUser),
      onLongPress: () => _onAvatarLongPress(messagedUser),
      profileAvatar: profileCircleConfig?.profileAvatar,
      user: messagedUser,
    );
  }

  void onRightSwipe() {
    if (maxDuration != null) {
      widget.message.voiceMessageDuration =
          Duration(milliseconds: maxDuration!);
    }
    if (chatListConfig.swipeToReplyConfig?.onRightSwipe != null) {
      chatListConfig.swipeToReplyConfig?.onRightSwipe!(
          widget.message.message, widget.message.sentBy);
    }
    widget.onSwipe(widget.message);
  }

  void onLeftSwipe() {
    if (maxDuration != null) {
      widget.message.voiceMessageDuration =
          Duration(milliseconds: maxDuration!);
    }
    if (chatListConfig.swipeToReplyConfig?.onLeftSwipe != null) {
      chatListConfig.swipeToReplyConfig?.onLeftSwipe!(
          widget.message.message, widget.message.sentBy);
    }
    widget.onSwipe(widget.message);
  }

  void _onAvatarTap(ChatUser? user) {
    if (chatListConfig.profileCircleConfig?.onAvatarTap != null &&
        user != null) {
      chatListConfig.profileCircleConfig?.onAvatarTap!(user);
    }
  }

  Widget getReceipt(bool isMessageBySender) {
    final chatBubbleConfig = isMessageBySender
        ? chatListConfig.chatBubbleConfig?.outgoingChatBubbleConfig
        : chatListConfig.chatBubbleConfig?.inComingChatBubbleConfig;
    final showReceipts =
        chatBubbleConfig?.receiptsWidgetConfig?.showReceiptsIn ??
            ShowReceiptsIn.lastMessage;
    if (showReceipts == ShowReceiptsIn.all) {
      return MultiValueListenableBuilder(
        listenables: [
          widget.message.statusNotifier,
          widget.message.unreadCountNotifier,
          widget.message.createdAtNotifier,
        ],
        builder: (context, values, child) {
          if (ChatViewInheritedWidget.of(context)
                  ?.featureActiveConfig
                  .receiptsBuilderVisibility ??
              true) {
            return chatBubbleConfig?.receiptsWidgetConfig?.receiptsBuilder
                    ?.call(widget.message) ??
                sendMessageAnimationBuilder(widget.message.status);
          }
          return const SizedBox();
        },
      );
    } else if (showReceipts == ShowReceiptsIn.lastMessage && isLastMessage) {
      return MultiValueListenableBuilder(
          listenables: [
            chatController!.initialMessageList.last.statusNotifier,
            chatController!.initialMessageList.last.unreadCountNotifier,
            chatController!.initialMessageList.last.createdAtNotifier,
          ],
          builder: (context, values, child) {
            if (ChatViewInheritedWidget.of(context)
                    ?.featureActiveConfig
                    .receiptsBuilderVisibility ??
                true) {
              return chatBubbleConfig?.receiptsWidgetConfig?.receiptsBuilder
                      ?.call(widget.message) ??
                  sendMessageAnimationBuilder(widget.message.status);
            }
            return sendMessageAnimationBuilder(widget.message.status);
          });
    }
    return const SizedBox();
  }

  void _onAvatarLongPress(ChatUser? user) {
    if (chatListConfig.profileCircleConfig?.onAvatarLongPress != null &&
        user != null) {
      chatListConfig.profileCircleConfig?.onAvatarLongPress!(user);
    }
  }

  Widget _messagesWidgetColumn(ChatUser? messagedUser) {
    return Column(
      crossAxisAlignment:
          isMessageBySender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if ((chatController?.otherUsers.isNotEmpty ?? false) &&
            !isMessageBySender &&
            (featureActiveConfig?.enableOtherUserName ?? true))
          Padding(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: Row(
              children: [
                Text(
                  messagedUser?.name ?? '',
                  style: chatListConfig.chatBubbleConfig
                      ?.inComingChatBubbleConfig?.senderNameTextStyle,
                ),
                const SizedBox(width: 3),
                if (messagedUser?.type == ChatUser.TYPE_USER)
                  Text(
                    messagedUser?.title != null
                        ? '· ${messagedUser?.title}'
                        : '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF717171),
                    ),
                  ),
                if (messagedUser?.type == ChatUser.TYPE_BOT)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF475467),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      messagedUser!.type!,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (replyMessage.isNotEmpty)
          chatListConfig.repliedMessageConfig?.repliedMessageWidgetBuilder !=
                  null
              ? chatListConfig
                      .repliedMessageConfig!.repliedMessageWidgetBuilder!(
                  widget.message.replyMessage, null)
              : ReplyMessageWidget(
                  message: widget.message,
                  repliedMessageConfig: chatListConfig.repliedMessageConfig,
                  onTap: () => widget.onReplyTap
                      ?.call(widget.message.replyMessage.messageId),
                ),
        SwipeToReply(
          isMessageByCurrentUser: isMessageBySender,
          onSwipe: isMessageBySender ? onLeftSwipe : onRightSwipe,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isMessageBySender)
                Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        widget.message.reaction.reactions.isNotEmpty ? 18 : 0,
                  ),
                  child: getReceipt(isMessageBySender),
                ),
              MessageView(
                outgoingChatBubbleConfig:
                    chatListConfig.chatBubbleConfig?.outgoingChatBubbleConfig,
                isLongPressEnable:
                    (featureActiveConfig?.enableReactionPopup ?? true) ||
                        (featureActiveConfig?.enableReplySnackBar ?? true),
                inComingChatBubbleConfig:
                    chatListConfig.chatBubbleConfig?.inComingChatBubbleConfig,
                message: widget.message,
                isMessageBySender: isMessageBySender,
                messageConfig: chatListConfig.messageConfig,
                onLongPress: widget.onLongPress,
                chatBubbleMaxWidth: chatListConfig.chatBubbleConfig?.maxWidth,
                longPressAnimationDuration:
                    chatListConfig.chatBubbleConfig?.longPressAnimationDuration,
                onDoubleTap: featureActiveConfig?.enableDoubleTapToLike ?? false
                    ? chatListConfig.chatBubbleConfig?.onDoubleTap ??
                        (message) => currentUser != null
                            ? chatController?.setReaction(
                                emoji: heart,
                                messageId: message.id,
                                userId: currentUser!.id,
                              )
                            : null
                    : null,
                shouldHighlight: widget.shouldHighlight,
                controller: chatController,
                highlightColor: chatListConfig.repliedMessageConfig
                        ?.repliedMsgAutoScrollConfig.highlightColor ??
                    Colors.grey,
                highlightScale: chatListConfig.repliedMessageConfig
                        ?.repliedMsgAutoScrollConfig.highlightScale ??
                    1.1,
                onMaxDuration: _onMaxDuration,
              ),
              if (!isMessageBySender)
                Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        widget.message.reaction.reactions.isNotEmpty ? 18 : 0,
                  ),
                  child: getReceipt(isMessageBySender),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _onMaxDuration(int duration) => maxDuration = duration;
}
