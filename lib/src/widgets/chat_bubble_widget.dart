import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/src/models/models.dart';

import 'message_view.dart';
import 'profile_circle.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.onLongPress,
    required this.showSenderProfileCircle,
    this.emojiMessagePadding,
    this.emojiMessageTextStyle,
    this.inComingChatBubble,
    this.outgoingChatBubble,
    this.messageReaction,
    this.imageMessage,
    this.profileCircleConfiguration,
    this.chatBubbleConfiguration,
    this.textMessage,
  }) : super(key: key);

  final Message message;
  final bool isCurrentUser;
  final void Function(double) onLongPress;
  final EdgeInsetsGeometry? emojiMessagePadding;
  final TextStyle? emojiMessageTextStyle;
  final ChatBubble? inComingChatBubble;
  final ChatBubble? outgoingChatBubble;
  final MessageReaction? messageReaction;
  final ImageMessage? imageMessage;
  final ProfileCircleConfiguration? profileCircleConfiguration;
  final bool showSenderProfileCircle;
  final ChatBubbleConfiguration? chatBubbleConfiguration;
  final TextMessage? textMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          chatBubbleConfiguration?.padding ?? const EdgeInsets.only(left: 5.0),
      margin:
          chatBubbleConfiguration?.margin ?? const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser && showSenderProfileCircle)
            ProfileCircle(
              bottomPadding: message.reaction.isNotEmpty
                  ? profileCircleConfiguration?.bottomPadding ?? 15
                  : profileCircleConfiguration?.bottomPadding ?? 2,
              profileCirclePadding: profileCircleConfiguration?.padding,
              imageUrl: profileCircleConfiguration?.senderProfileImageUrl,
              circleRadius: profileCircleConfiguration?.circleRadius,
            ),
          MessageView(
            textMessage: textMessage,
            outgoingChatBubble: outgoingChatBubble,
            inComingChatBubble: inComingChatBubble,
            message: message,
            isCurrentUser: isCurrentUser,
            emojiMessageTextStyle: emojiMessageTextStyle,
            onLongPress: onLongPress,
            chatBubbleMaxWidth: chatBubbleConfiguration?.maxWidth,
            emojiMessagePadding: emojiMessagePadding,
            messageReaction: messageReaction,
            imageMessage: imageMessage,
          ),
        ],
      ),
    );
  }
}
