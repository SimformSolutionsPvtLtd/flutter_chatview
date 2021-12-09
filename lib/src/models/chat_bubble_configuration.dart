import 'package:flutter/material.dart';

import '../values/typedefs.dart';
import 'models.dart';

class ChatBubbleConfiguration {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? maxWidth;
  final Duration? longPressAnimationDuration;
  final ChatBubble? inComingChatBubbleConfig;
  final ChatBubble? outgoingChatBubbleConfig;
  final MessageCallBack? onDoubleTap;

  ChatBubbleConfiguration({
    this.padding,
    this.margin,
    this.maxWidth,
    this.longPressAnimationDuration,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.onDoubleTap,
  });
}
