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
import 'package:chatview/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../chatview.dart';
import 'message_time_widget.dart';
import 'message_view.dart';
import 'profile_circle.dart';
import 'reply_message_widget.dart';
import 'swipe_to_reply.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    Key? key,
    required this.message,
    required this.onLongPress,
    required this.showReceiverProfileCircle,
    required this.horizontalDragToShowTime,
    required this.chatController,
    required this.slideAnimation,
    required this.onSwipe,
    required this.sender,
    required this.receiver,
    this.profileCircleConfig,
    this.chatBubbleConfig,
    this.repliedMessageConfig,
    this.swipeToReplyConfig,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
    this.messageConfig,
  }) : super(key: key);

  final Message message;
  final DoubleCallBack onLongPress;
  final ProfileCircleConfiguration? profileCircleConfig;
  final bool showReceiverProfileCircle;
  final ChatBubbleConfiguration? chatBubbleConfig;
  final RepliedMessageConfiguration? repliedMessageConfig;
  final SwipeToReplyConfiguration? swipeToReplyConfig;
  final TextStyle? messageTimeTextStyle;
  final Color? messageTimeIconColor;
  final bool horizontalDragToShowTime;
  final Animation<Offset> slideAnimation;
  final MessageConfiguration? messageConfig;
  final MessageCallBack onSwipe;
  final ChatUser sender;
  final ChatUser receiver;
  final ChatController chatController;

  String get replyMessage => message.replyMessage.message;

  bool get isMessageBySender => message.sendBy == sender.id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (horizontalDragToShowTime)
          Visibility(
            visible: slideAnimation.value.dx == 0.0 ? false : true,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: MessageTimeWidget(
                  messageTime: message.createdAt,
                  isCurrentUser: isMessageBySender,
                  messageTimeIconColor: messageTimeIconColor,
                  messageTimeTextStyle: messageTimeTextStyle,
                ),
              ),
            ),
          ),
        SlideTransition(
          position: slideAnimation,
          child: Container(
            padding:
                chatBubbleConfig?.padding ?? const EdgeInsets.only(left: 5.0),
            margin:
                chatBubbleConfig?.margin ?? const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMessageBySender
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isMessageBySender && showReceiverProfileCircle)
                  ProfileCircle(
                    bottomPadding: message.reaction.isNotEmpty
                        ? profileCircleConfig?.bottomPadding ?? 15
                        : profileCircleConfig?.bottomPadding ?? 2,
                    profileCirclePadding: profileCircleConfig?.padding,
                    imageUrl: profileCircleConfig?.profileImageUrl,
                    circleRadius: profileCircleConfig?.circleRadius,
                  ),
                Expanded(
                  child: isMessageBySender
                      ? SwipeToReply(
                          onLeftSwipe: () {
                            if (swipeToReplyConfig?.onLeftSwipe != null) {
                              swipeToReplyConfig?.onLeftSwipe!(
                                  message.message, message.sendBy);
                            }
                            onSwipe(message);
                          },
                          replyIconColor: swipeToReplyConfig?.replyIconColor,
                          swipeToReplyAnimationDuration:
                              swipeToReplyConfig?.animationDuration,
                          child: _messagesWidgetColumn,
                        )
                      : SwipeToReply(
                          onRightSwipe: () {
                            if (swipeToReplyConfig?.onRightSwipe != null) {
                              swipeToReplyConfig?.onRightSwipe!(
                                  message.message, message.sendBy);
                            }
                            onSwipe(message);
                          },
                          replyIconColor: swipeToReplyConfig?.replyIconColor,
                          swipeToReplyAnimationDuration:
                              swipeToReplyConfig?.animationDuration,
                          child: _messagesWidgetColumn,
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _messagesWidgetColumn {
    return Column(
      crossAxisAlignment:
          isMessageBySender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (replyMessage.isNotEmpty)
          repliedMessageConfig?.repliedMessageWidgetBuilder != null
              ? repliedMessageConfig!
                  .repliedMessageWidgetBuilder!(message.replyMessage)
              : ReplyMessageWidget(
                  message: message,
                  repliedMessageConfig: repliedMessageConfig,
                  receiver: receiver,
                  sender: sender,
                ),
        MessageView(
          outgoingChatBubbleConfig: chatBubbleConfig?.outgoingChatBubbleConfig,
          inComingChatBubbleConfig: chatBubbleConfig?.inComingChatBubbleConfig,
          message: message,
          isMessageBySender: isMessageBySender,
          emojiMessageConfig: messageConfig?.emojiMessageConfig,
          onLongPress: onLongPress,
          chatBubbleMaxWidth: chatBubbleConfig?.maxWidth,
          messageReactionConfig: messageConfig?.messageReactionConfig,
          imageMessageConfig: messageConfig?.imageMessageConfig,
          longPressAnimationDuration:
              chatBubbleConfig?.longPressAnimationDuration,
          onDoubleTap: chatBubbleConfig?.onDoubleTap ??
              (message) => chatController.setReaction(heart, message.id),
        ),
      ],
    );
  }
}
