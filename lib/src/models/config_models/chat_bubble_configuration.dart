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
import 'package:chatview/src/models/config_models/receipts_widget_config.dart';
import 'package:flutter/material.dart';

import '../../values/typedefs.dart';
import '../models.dart';

class ChatBubbleConfiguration {
  /// Used for giving padding of chat bubble.
  final EdgeInsetsGeometry? padding;

  /// Used for giving margin of chat bubble.
  final EdgeInsetsGeometry? margin;

  /// Used for giving maximum width of chat bubble.
  final double? maxWidth;

  /// Provides callback when user long press on chat bubble.
  final Duration? longPressAnimationDuration;

  /// Provides configuration of other users message's chat bubble.
  final ChatBubble? incomingChatBubble;

  /// Provides configuration of current user message's chat bubble.
  final ChatBubble? outgoingChatBubble;

  /// Provides callback when user tap twice on chat bubble.
  final MessageCallBack? onDoubleTap;

  final ReceiptsWidgetConfig? receiptsWidgetConfig;

  /// A flag to disable link preview functionality.
  ///
  /// When `true`, link previews will be disabled, rendering links as plain text
  /// or standard hyperlinks without additional preview metadata.
  /// When `false`, link previews will be enabled by default (current behavior).
  ///
  /// Default value: `false`.
  final bool disableLinkPreview;

  const ChatBubbleConfiguration({
    this.padding,
    this.margin,
    this.maxWidth,
    this.longPressAnimationDuration,
    this.incomingChatBubble,
    this.outgoingChatBubble,
    this.onDoubleTap,
    this.receiptsWidgetConfig,
    this.disableLinkPreview = false,
  });
}
