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
import '../values/enumaration.dart';

class ReplyMessage {
  /// Provides reply message.
  final String message;

  /// Provides user id of who replied message.
  final String replyBy;

  /// Provides user id of whom to reply.
  final String replyTo;
  final MessageType messageType;

  /// Provides max duration for recorded voice message.
  final Duration? voiceMessageDuration;

  /// Id of message, it replies to.
  final String messageId;

  const ReplyMessage({
    this.messageId = '',
    this.message = '',
    this.replyTo = '',
    this.replyBy = '',
    this.messageType = MessageType.text,
    this.voiceMessageDuration,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message'].toString(),
        replyBy: json['replyBy'].toString(),
        replyTo: json['replyTo'].toString(),
        messageType: (json["message_type"] is String)
            ? getMessageType(json["message_type"])
            : MessageType.text,
        messageId: json["id"].toString(),
        voiceMessageDuration: (json["voiceMessageDuration"] is String)
            ? parseDuration(json["voiceMessageDuration"])
            : json["voiceMessageDuration"],
      );

  Map<String, dynamic> toJson() => {
        'message': message ?? "",
        'replyBy': replyBy ?? "",
        'replyTo': replyTo ?? "",
        'message_type': messageType,
        'id': messageId ?? "",
        'voiceMessageDuration': voiceMessageDuration,
      };

  static getMessageType(String? type) {
    switch (type) {
      case 'MessageType.text':
        return MessageType.text;
      case 'MessageType.image':
        return MessageType.image;
      case 'MessageType.video':
        return MessageType.video;
      case 'MessageType.audio':
        return MessageType.voice;
      case 'MessageType.voice':
        return MessageType.voice;
    }
    return MessageType.text;
  }

  static Duration parseDuration(String? s) {
    if (s == null) {
      return Duration.zero;
    }

    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
