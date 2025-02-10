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


class ReplyMessage {
  /// Provides reply message.
  final String message;

  /// Provides user id of who replied message.
  final int replyBy;

  /// Provides user id of whom to reply.
  final int replyTo;
  final MessageType messageType;

  /// Provides max duration for recorded voice message.
  final Duration? voiceMessageDuration;

  /// Id of message, it replies to.
  final int messageId;

  const ReplyMessage({
    this.messageId = messageEmptyId,
    this.message = '',
    this.replyTo = userEmptyId,
    this.replyBy = userEmptyId,
    this.messageType = MessageType.text,
    this.voiceMessageDuration,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message']?.toString() ?? '',
        replyBy: json['reply_by'] ?? userEmptyId,
        replyTo: json['reply_to'] ?? userEmptyId,
        messageType: MessageType.tryParse(json['message_type']?.toString()) ??
            MessageType.text,
        messageId: json['id'] ?? messageEmptyId,
        voiceMessageDuration: Duration(
          microseconds:
              int.tryParse(json['voiceMessageDuration'].toString()) ?? 0,
        ),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'reply_by': replyBy,
        'reply_to': replyTo,
        'message_type': messageType.name,
        'id': messageId,
        'voiceMessageDuration': voiceMessageDuration?.inMicroseconds,
      };

  ReplyMessage copyWith({
    int? messageId,
    String? message,
    int? replyTo,
    int? replyBy,
    MessageType? messageType,
    Duration? voiceMessageDuration,
    bool forceNullValue = false,
  }) {
    return ReplyMessage(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      replyTo: replyTo ?? this.replyTo,
      replyBy: replyBy ?? this.replyBy,
      messageType: messageType ?? this.messageType,
      voiceMessageDuration: forceNullValue
          ? voiceMessageDuration
          : voiceMessageDuration ?? this.voiceMessageDuration,
    );
  }
}
