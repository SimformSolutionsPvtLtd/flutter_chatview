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
  /// Used for background color in reaction pop-up.
  final Color? backgroundColor;

  /// Used for shadow in reaction pop-up.
  final BoxShadow? shadow;

  /// Used for animation duration while reaction pop-up opens.
  final Duration? animationDuration;

  /// Used for max width in reaction pop-up.
  final double? maxWidth;

  /// Used for give margin in reaction pop-up.
  final EdgeInsetsGeometry? margin;

  /// Used for give padding in reaction pop-up.
  final EdgeInsetsGeometry? padding;

  /// Provides emoji configuration in reaction pop-up.
  final EmojiConfiguration? emojiConfig;

  /// Used for showing glass morphism effect on reaction pop-up.
  final bool showGlassMorphismEffect;

  /// Provides glass morphism effect configuration.
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
  /// Provides list of emojis.
  final List<String>? emojiList;

  /// Used to give size of emoji.
  final double? size;

  EmojiConfiguration({
    this.emojiList,
    this.size,
  });
}

class GlassMorphismConfiguration {
  /// Used to give border color of reaction pop-up.
  final Color? borderColor;

  /// Used to give stroke width of reaction pop-up.
  final double? strokeWidth;

  /// Used to give background color of reaction pop-up.
  final Color? backgroundColor;

  /// Used to give border radius of reaction pop-up.
  final double? borderRadius;

  GlassMorphismConfiguration({
    this.borderColor,
    this.strokeWidth,
    this.backgroundColor,
    this.borderRadius,
  });
}
