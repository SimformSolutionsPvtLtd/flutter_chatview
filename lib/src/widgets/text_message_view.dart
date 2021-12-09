import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_chat_ui/src/constants.dart';
import 'package:flutter_chat_ui/src/models/models.dart';

class TextMessageView extends StatelessWidget {
  const TextMessageView({
    Key? key,
    required this.isCurrentUser,
    required this.message,
    this.chatBubbleMaxWidth,
    this.inComingChatBubble,
    this.outgoingChatBubble,
    this.textMessage,
  }) : super(key: key);

  final bool isCurrentUser;
  final Message message;
  final double? chatBubbleMaxWidth;
  final ChatBubble? inComingChatBubble;
  final ChatBubble? outgoingChatBubble;
  final TextMessage? textMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _textMessage = message.message;
    return Container(
      constraints: BoxConstraints(maxWidth: chatBubbleMaxWidth ?? 280),
      padding: textMessage?.padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: textMessage?.margin ??
          EdgeInsets.fromLTRB(5, 0, 6, message.reaction.isNotEmpty ? 15 : 2),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius(_textMessage),
      ),
      child: Linkify(
        onOpen: (link) => _launchURL(link.url),
        text: _textMessage,
        style: _textStyle ?? textTheme.bodyText2!.copyWith(color: Colors.white),
        linkStyle:
            textMessage?.linkTextStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }

  TextStyle? get _textStyle => isCurrentUser
      ? outgoingChatBubble?.textStyle
      : inComingChatBubble?.textStyle;

  BorderRadiusGeometry _borderRadius(String message) => isCurrentUser
      ? outgoingChatBubble?.borderRadius ??
          (message.length < 37
              ? BorderRadius.circular(30)
              : BorderRadius.circular(18))
      : inComingChatBubble?.borderRadius ??
          (message.length < 29
              ? BorderRadius.circular(30)
              : BorderRadius.circular(18));

  Color? get _color => isCurrentUser
      ? outgoingChatBubble?.color ?? Colors.purple
      : inComingChatBubble?.color ?? Colors.grey.shade500;

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw couldNotLunch;
}
