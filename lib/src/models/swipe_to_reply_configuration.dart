import 'package:flutter/material.dart';

class SwipeToReplyConfiguration {
  final Color? replyIconColor;
  final Duration? animationDuration;
  final void Function(String message, String sendBy)? onLeftSwipe;
  final void Function(String message, String sendBy)? onRightSwipe;

  SwipeToReplyConfiguration({
    this.replyIconColor,
    this.animationDuration,
    this.onRightSwipe,
    this.onLeftSwipe,
  });
}
