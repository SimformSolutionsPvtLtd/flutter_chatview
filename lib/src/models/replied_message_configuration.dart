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
import '../values/typedefs.dart';

class RepliedMessageConfiguration {
  final Color? verticalBarColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle? replyTitleTextStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final BorderRadiusGeometry? borderRadius;
  final double? verticalBarWidth;
  final double? repliedImageMessageHeight;
  final double? repliedImageMessageWidth;
  final BorderRadiusGeometry? repliedImageMessageBorderRadius;
  final double? opacity;
  final ReplyMessageWithReturnWidget? repliedMessageWidgetBuilder;

  RepliedMessageConfiguration({
    this.verticalBarColor,
    this.backgroundColor,
    this.textStyle,
    this.replyTitleTextStyle,
    this.margin,
    this.padding,
    this.maxWidth,
    this.borderRadius,
    this.verticalBarWidth,
    this.repliedImageMessageHeight,
    this.repliedImageMessageWidth,
    this.repliedImageMessageBorderRadius,
    this.repliedMessageWidgetBuilder,
    this.opacity,
  });
}
