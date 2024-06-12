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
import 'package:chatview/src/models/models.dart';
import 'package:chatview/src/models/voice_message_configuration.dart';
import 'package:chatview/src/widgets/message_view.dart';
import 'package:flutter/material.dart';

import '../values/typedefs.dart';

class MessageConfiguration {
  /// Provides configuration of message reaction.
  final MessageReactionConfiguration? messageReactionConfig;

  /// Provides configuration of emoji messages appearance.
  final EmojiMessageConfiguration? emojiMessageConfig;

  /// Provides configuration of image message appearance.
  final ImageMessageConfiguration? imageMessageConfig;

  /// Configurations for voice message bubble
  final VoiceMessageConfiguration? voiceMessageConfig;

  /// Provides builder to create view for emoji messages.
  final Widget Function(MessageView)? emojiMessageBuilder;

  /// Provides builder to create view for image messages.
  final Widget Function(MessageView)? imageMessageBuilder;

  /// Provides builder to create view for text messages.
  final Widget Function(MessageView)? textMessageBuilder;

  /// Provides builder to create view for voice messages.
  final Widget Function(MessageView)? voiceMessageBuilder;

  /// Provides builder to create view for custom messages.
  final Widget Function(MessageView)? customMessageBuilder;

  /// To customize reply view for custom message type
  final CustomMessageReplyViewBuilder? customMessageReplyViewBuilder;

  const MessageConfiguration({
    this.imageMessageBuilder,
    this.textMessageBuilder,
    this.emojiMessageBuilder,
    this.voiceMessageBuilder,
    this.imageMessageConfig,
    this.messageReactionConfig,
    this.emojiMessageConfig,
    this.customMessageBuilder,
    this.voiceMessageConfig,
    this.customMessageReplyViewBuilder,
  });
}
