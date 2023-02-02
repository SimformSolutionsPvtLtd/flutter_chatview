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
import 'package:chatview/chatview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String id;
  final GlobalKey key;
  final String message;
  final DateTime createdAt;
  final String sendBy;
  final ReplyMessage replyMessage;
  final Reaction reaction;
  final MessageType messageType;

  /// Provides max duration for recorded voice message.
  Duration? voiceMessageDuration;

  Message({
    this.id = '',
    required this.message,
    required this.createdAt,
    required this.sendBy,
    this.replyMessage = const ReplyMessage(),
    Reaction? reaction,
    this.messageType = MessageType.text,
    this.voiceMessageDuration,
  })  : reaction = reaction ?? Reaction(reactions: [], reactedUserIds: []),
        key = GlobalKey(),
        assert(
          (messageType.isVoice
              ? ((defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.android))
              : true),
          "Voice messages are only supported with android and ios platform",
        );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
        sendBy: json["sendBy"],
        replyMessage: ReplyMessage.fromJson(json["reply_message"]),
        reaction: Reaction.fromJson(json["reaction"]),
        messageType: json["message_type"],
        voiceMessageDuration: json["voice_message_duration"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'createdAt': createdAt,
        'sendBy': sendBy,
        'reply_message': replyMessage.toJson(),
        'reaction': reaction.toJson(),
        'message_type': messageType,
        'voice_message_duration': voiceMessageDuration,
      };
}
