import 'package:chatview/chatview.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:meta/meta.dart';
import 'audio_message/audio_message.dart';
import 'custom_message/custom_message.dart';
import 'image_message/image_message.dart';
import 'text_message/text_message.dart';
import 'user.dart' show ChatUser;

/// All possible message types.

/// All possible statuses message can have.
enum MessageStatus {
  error,
  sending,
  sent,
  read,
  delivered,
  undelivered,
  pending,
  custom,
}

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  Message({
    required this.author,
    GlobalKey? key,
    required this.createdAt,
    required this.id,
    this.metadata,
    this.remoteId,
    this.repliedMessage,
    this.roomId,
    this.showStatus,
    MessageStatus? status,
    required this.type,
    this.updatedAt,
    this.reaction,
  }) {
    _key = key ?? GlobalKey();
    this.status = status ?? MessageStatus.pending;
  }

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = MessageType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageType.unsupported,
    );

    switch (type) {
      case MessageType.custom:
        return CustomMessage.fromJson(json);
      case MessageType.voice:
        return AudioMessage.fromJson(json);
      case MessageType.image:
        return ImageMessage.fromJson(json);
      case MessageType.text:
        return TextMessage.fromJson(json);
      default:
        return TextMessage(
            author: json['author'],
            createdAt: json['createdAt'],
            id: json['id'],
            text: 'Message Unsupported');
    }
  }

  /// Key
  late final GlobalKey _key;

  /// ChatUser who sent this message.
  final ChatUser author;

  /// Created message timestamp, in ms.
  final int createdAt;

  /// Unique ID of the message.
  final String id;

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Unique ID of the message received from the backend.
  final String? remoteId;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// ID of the room where this message is sent.
  final String? roomId;

  /// Show status or not.
  final bool? showStatus;

  /// Message [MessageStatus].
  late final MessageStatus status;

  /// [MessageType].
  final MessageType type;

  /// Updated message timestamp, in ms.
  final int? updatedAt;

  /// Reactions by the user.
  final Reaction? reaction;

  GlobalKey get key => _key;

  /// Creates a copy of the message with an updated data.
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Reaction? reaction,
    MessageStatus? status,
    int? updatedAt,
  });

  /// Converts a particular message to the map representation, serializable to JSON.
  Map<String, dynamic> toJson();
}
