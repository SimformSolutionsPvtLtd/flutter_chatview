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
import 'package:flutter/material.dart';

class ReactionPopupConfiguration {
  final Color? backgroundColor;
  final BoxShadow? shadow;
  final Duration? animationDuration;
  final double? maxWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EmojiConfiguration? emojiConfig;
  final bool showGlassMorphismEffect;
  final GlassMorphismConfiguration? glassMorphismConfig;

  ReactionPopupConfiguration({
    this.showGlassMorphismEffect = false,
    this.backgroundColor,
    this.shadow,
    this.animationDuration,
    this.maxWidth,
    this.margin,
    this.padding,
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
