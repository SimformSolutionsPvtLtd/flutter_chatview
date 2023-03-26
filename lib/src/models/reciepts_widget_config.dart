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

import 'package:flutter/cupertino.dart';
import '../../chatview.dart';
import '../utils/constants/constants.dart';

class RecieptsWidgetConfig {
  /// The builder that builds widget that right next to the senders message bubble.
  /// Right now it's implemented to show animation only at the last message just
  /// like instagram.
  /// By default [sendMessageAnimationBuilder]
  final Widget Function(MessageStatus status)? recieptsBuilder;

  /// Just like Instagram messages reciepts are displayed at the bottom of last
  /// message. If in case you want to modify it using your custom widget you can
  /// utilize this function.
  final Widget Function(Message message, String formattedDate)?
      lastSeenAgoBuilder;

  /// Controls the visibility of message seen ago reciepts default is true
  final bool messageSeenAgoRecieptVisible;

  /// Controls the visibility of the message [recieptsBuilder]
  final bool recieptsBuilderVisibility;

  /// Whether to show reciepts in all messages or not defaults to [ShowRecieptsIn.lastMessage]
  final ShowRecieptsIn showRecieptsIn;

  const RecieptsWidgetConfig(
      {this.recieptsBuilder,
      this.lastSeenAgoBuilder,
      this.messageSeenAgoRecieptVisible = true,
      this.recieptsBuilderVisibility = true,
      this.showRecieptsIn = ShowRecieptsIn.lastMessage});
}
