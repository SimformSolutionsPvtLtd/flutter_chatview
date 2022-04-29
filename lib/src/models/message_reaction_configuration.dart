import 'package:flutter/material.dart';

class MessageReactionConfiguration {
  final double? reactionSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  MessageReactionConfiguration({
    this.reactionSize,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });
}
