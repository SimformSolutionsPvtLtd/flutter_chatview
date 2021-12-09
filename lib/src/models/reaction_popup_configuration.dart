import 'package:flutter/material.dart';

import '../values/typedefs.dart';

class ReactionPopupConfiguration {
  final Color? backgroundColor;
  final BoxShadow? shadow;
  final Duration? animationDuration;
  final double? maxWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EmojiConfiguration? emojiConfig;
  final bool showGlassMorphismEffect;
  final StringsCallBack? onEmojiTap;
  final GlassMorphismConfiguration? glassMorphismConfig;

  ReactionPopupConfiguration({
    this.showGlassMorphismEffect = false,
    this.backgroundColor,
    this.shadow,
    this.animationDuration,
    this.maxWidth,
    this.margin,
    this.padding,
    this.onEmojiTap,
    this.emojiConfig,
    this.glassMorphismConfig,
  });
}

class EmojiConfiguration {
  final List<String>? emojiList;
  final double? size;

  EmojiConfiguration({
    this.emojiList,
    this.size,
  });
}

class GlassMorphismConfiguration {
  final Color? borderColor;
  final double? strokeWidth;
  final Color? backgroundColor;
  final double? borderRadius;

  GlassMorphismConfiguration({
    this.borderColor,
    this.strokeWidth,
    this.backgroundColor,
    this.borderRadius,
  });
}
