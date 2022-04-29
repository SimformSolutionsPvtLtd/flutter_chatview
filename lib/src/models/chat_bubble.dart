import 'package:flutter/material.dart';

import 'link_preview_configuration.dart';

class ChatBubble {
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final LinkPreviewConfiguration? linkPreviewConfig;

  ChatBubble({
    this.color,
    this.borderRadius,
    this.textStyle,
    this.padding,
    this.margin,
    this.linkPreviewConfig,
  });
}
