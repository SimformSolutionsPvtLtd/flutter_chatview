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
import 'package:grouped_list/grouped_list.dart';

import '../values/typedefs.dart';

class ChatBackgroundConfiguration {
  final Color? backgroundColor;
  final String? backgroundImage;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final GroupedListOrder groupedListOrder;
  final bool sortEnable;
  final bool horizontalDragToShowMessageTime;
  final TextStyle? messageTimeTextStyle;
  final Color? messageTimeIconColor;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;
  final Widget? loadingWidget;
  final Curve messageTimeAnimationCurve;

  const ChatBackgroundConfiguration({
    this.defaultGroupSeparatorConfig,
    this.backgroundColor,
    this.backgroundImage,
    this.height,
    this.width,
    this.groupSeparatorBuilder,
    this.groupedListOrder = GroupedListOrder.ASC,
    this.sortEnable = false,
    this.horizontalDragToShowMessageTime = true,
    this.padding,
    this.margin,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
    this.loadingWidget,
    this.messageTimeAnimationCurve = Curves.decelerate,
  });
}

class DefaultGroupSeparatorConfiguration {
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  DefaultGroupSeparatorConfiguration({
    this.padding,
    this.textStyle,
  });
}
