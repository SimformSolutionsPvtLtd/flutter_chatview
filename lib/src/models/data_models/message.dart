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

const messageEmptyId = 0;
const userEmptyId = 0;

class Message {

  /// Provides id
  final int id;

  /// Used for accessing widget's render box.
  final GlobalKey key;

  /// Provides actual message it will be text or image/audio file path.
  final String message;

  /// Provides message created date time.
  final DateTime createdAt;

  /// Provides id of sender of message.
  final int sentBy;

  /// Provides reply message if user triggers any reply on any message.
  final ReplyMessage? replyMessage;

  /// Represents reaction on message.
  final Reaction reaction;

  /// Provides message type.
  final MessageType messageType;

  /// Status of the message.
  final ValueNotifier<MessageStatus> _status;

  /// Provides max duration for recorded voice message.
  Duration? voiceMessageDuration;

  Message({
    this.id = messageEmptyId,
    required this.message,
    required this.createdAt,
    required this.sentBy,
    this.replyMessage,
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


  factory Message.fromJson(dynamic json) {
    return Message(
      id: json['id'],
      sentBy: json['sender_id'],
      message: json['text'] ?? json['file'],
        replyMessage: json['reply_message'] is Map<String, dynamic>
                  ? ReplyMessage.fromJson(json['reply_message'])
                  : null,
        reaction: json['reaction'] is Map<String, dynamic>
                  ? Reaction.fromJson(json['reaction'])
                  : null,

              voiceMessageDuration: Duration(
                microseconds:
                    int.tryParse(json['voice_message_duration'].toString()) ?? 0,
              ),
              messageType: json['text'] != null ? MessageType.text : MessageType.image,
      createdAt: DateTime.parse(json['date_created']).toLocal(),
      status: json['read'] ? MessageStatus.read : MessageStatus.delivered,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ret = {
      'sender_id': sentBy,
    //  'reply_message': replyMessage?.messageId,
      //'reaction': reaction.toJson(),
      //'message_type': messageType.name,
      //'voice_message_duration': voiceMessageDuration?.inMicroseconds,
    };

    if (messageType == MessageType.text) {
      ret['text'] = message;
    } else {
      ret['file'] = message;
    }
    return ret;
  }

  Message copyWith({
    int? id,
    GlobalKey? key,
    String? message,
    DateTime? createdAt,
    int? sentBy,
    ReplyMessage? replyMessage,
    Reaction? reaction,
    MessageType? messageType,
    Duration? voiceMessageDuration,
    MessageStatus? status,
    bool forceNullValue = false,
  }) {
    return Message(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      sentBy: sentBy ?? this.sentBy,
      messageType: messageType ?? this.messageType,
      voiceMessageDuration: forceNullValue
          ? voiceMessageDuration
          : voiceMessageDuration ?? this.voiceMessageDuration,
      reaction: reaction ?? this.reaction,
      replyMessage: replyMessage ?? this.replyMessage,
      status: status ?? this.status,
    );
  }
}
