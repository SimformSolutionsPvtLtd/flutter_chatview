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
  /// Provides id
  final String id;

  /// Used for accessing widget's render box.
  final GlobalKey key;

  /// Provides actual message it will be text or image/audio file path.
  final String message;

  /// Provides message created date time.
  final DateTime createdAt;

  /// Provides id of sender of message.
  final String sendBy;

  /// Provides reply message if user triggers any reply on any message.
  final ReplyMessage replyMessage;

  /// Represents reaction on message.
  final Reaction reaction;

  /// Provides message type.
  final MessageType messageType;

  /// Status of the message.
  final ValueNotifier<MessageStatus> _status;

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
    MessageStatus status = MessageStatus.pending,
  })  : reaction = reaction ?? Reaction(reactions: [], reactedUserIds: []),
        key = GlobalKey(),
        _status = ValueNotifier(status),
        assert(
          (messageType.isVoice
              ? ((defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.android))
              : true),
          "Voice messages are only supported with android and ios platform",
        );

  /// curret messageStatus
  MessageStatus get status => _status.value;

  /// For [MessageStatus] ValueNotfier which is used to for rebuilds
  /// when state changes.
  /// Using ValueNotfier to avoid usage of setState((){}) in order
  /// rerender messages with new receipts.
  ValueNotifier<MessageStatus> get statusNotifier => _status;

  /// This setter can be used to update message receipts, after which the configured
  /// builders will be updated.
  set setStatus(MessageStatus messageStatus) {
    _status.value = messageStatus;
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json["id"],
      message: json["message"],
      createdAt: (json["createdAt"] is String)
          ? DateTime.parse(json["createdAt"])
          : json["createdAt"],
      sendBy: json["sendBy"],
      replyMessage: ReplyMessage.fromJson(json["reply_message"]),
      reaction: (json["reaction"] != null)
          ? Reaction.fromJson(json["reaction"])
          : Reaction(reactions: [], reactedUserIds: []),
      messageType: (json["message_type"] is String)
          ? getMessageType(json["message_type"])
          : json["message_type"],
      voiceMessageDuration: (json["voice_message_duration"] is String)
          ? parseDuration(json["voice_message_duration"])
          : json["voice_message_duration"],
      status: (json['status'] is String)
          ? getMessageStatus(json['status'])
          : MessageStatus.pending);

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'createdAt': createdAt,
        'sendBy': sendBy,
        'reply_message': replyMessage.toJson(),
        'reaction': reaction.toJson(),
        'message_type': messageType,
        'voice_message_duration': voiceMessageDuration,
        'status': status.name
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

  static MessageStatus getMessageStatus(String? status) {
    switch (status) {
      case 'pending':
        return MessageStatus.pending;
      case 'undelivered':
        return MessageStatus.undelivered;
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
    }
    return MessageStatus.pending;
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
