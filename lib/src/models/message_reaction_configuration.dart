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

class MessageReactionConfiguration {
  final double? reactionSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final TextStyle? reactedUserCountTextStyle;
  final TextStyle? reactionCountTextStyle;
  final ReactionsBottomSheetConfiguration? reactionsBottomSheetConfig;
  final double? profileCircleRadius;
  final EdgeInsets? profileCirclePadding;

  MessageReactionConfiguration({
    this.reactionsBottomSheetConfig,
    this.reactionCountTextStyle,
    this.reactedUserCountTextStyle,
    this.reactionSize,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.profileCircleRadius,
    this.profileCirclePadding,
  });
}

class ReactionsBottomSheetConfiguration {
  ReactionsBottomSheetConfiguration({
    this.bottomSheetPadding,
    this.backgroundColor,
    this.reactionWidgetDecoration,
    this.reactionWidgetPadding,
    this.reactionWidgetMargin,
    this.reactedUserTextStyle,
    this.profileCircleRadius,
    this.reactionSize,
  });

  final EdgeInsetsGeometry? bottomSheetPadding;
  final EdgeInsetsGeometry? reactionWidgetPadding;
  final EdgeInsetsGeometry? reactionWidgetMargin;
  final Color? backgroundColor;
  final BoxDecoration? reactionWidgetDecoration;
  final TextStyle? reactedUserTextStyle;
  final double? profileCircleRadius;
  final double? reactionSize;
}
