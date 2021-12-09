import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/src/helper/emoji_helpar.dart';
import 'package:flutter_chat_ui/src/helper/helper_functions.dart';
import 'package:flutter_chat_ui/src/models/models.dart';

import 'image_message_view.dart';
import 'text_message_view.dart';
import 'reaction_widget.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.onLongPress,
    this.chatBubbleMaxWidth,
    this.emojiMessagePadding,
    this.emojiMessageTextStyle,
    this.inComingChatBubble,
    this.outgoingChatBubble,
    this.messageReaction,
    this.imageMessage,
    this.textMessage,
  }) : super(key: key);

  final Message message;
  final bool isCurrentUser;
  final void Function(double) onLongPress;
  final double? chatBubbleMaxWidth;
  final EdgeInsetsGeometry? emojiMessagePadding;
  final TextStyle? emojiMessageTextStyle;
  final ChatBubble? inComingChatBubble;
  final ChatBubble? outgoingChatBubble;
  final MessageReaction? messageReaction;
  final ImageMessage? imageMessage;
  final TextMessage? textMessage;

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      upperBound: 0.1,
      lowerBound: 0.0,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message.message;
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) async {
        await _animationController.forward();
        widget.onLongPress(details.globalPosition.dy -
            (Scaffold.of(context).appBarMaxHeight ?? 0.0) -
            64);
      },
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: 1 - _animationController.value,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                EmojiHelper.checkEmoji(message)
                    ? Padding(
                        padding: widget.emojiMessagePadding ??
                            const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 5),
                        child: Text(
                          message,
                          style: widget.emojiMessageTextStyle ??
                              const TextStyle(fontSize: 30),
                        ),
                      )
                    : isImageUrl(message)
                        ? ImageMessageView(
                            message: widget.message,
                            isCurrentUser: widget.isCurrentUser,
                            imageMessage: widget.imageMessage,
                          )
                        : TextMessageView(
                            inComingChatBubble: widget.inComingChatBubble,
                            outgoingChatBubble: widget.outgoingChatBubble,
                            isCurrentUser: widget.isCurrentUser,
                            message: widget.message,
                            textMessage: widget.textMessage,
                            chatBubbleMaxWidth: widget.chatBubbleMaxWidth,
                          ),
                if (widget.message.reaction.isNotEmpty)
                  ReactionWidget(
                    reaction: widget.message.reaction.toString(),
                    messageReaction: widget.messageReaction,
                  ),
              ],
            ),
          );
        },
        animation: _animationController,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
