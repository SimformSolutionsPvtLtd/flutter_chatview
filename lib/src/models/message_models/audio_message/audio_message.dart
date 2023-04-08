import 'dart:io' if (kIsWeb) 'dart:html';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../../../values/enumaration.dart';
import '../../reaction.dart';
import '../message.dart';
import '../user.dart' show ChatUser;
import 'partial_audio.dart';

part 'audio_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
@immutable
abstract class AudioMessage extends Message {
  /// Creates a file message.
  AudioMessage({
    required super.author,
    required super.createdAt,
    required super.id,
    required this.duration,
    required this.size,
    this.isLoading,
    super.metadata,
    super.reaction,
    this.mimeType,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.voice);

  factory AudioMessage.network({
    required ChatUser author,
    required int createdAt,
    required String id,
    bool? isLoading,
    Reaction? reaction,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    MessageStatus? status,
    MessageType? type,
    required int duration,
    int? updatedAt,
    required String uri,
  }) =>
      AudioPathMessage(
        uri,
        author: author,
        reaction: reaction,
        createdAt: createdAt,
        id: id,
        isLoading: isLoading,
        metadata: metadata,
        mimeType: mimeType,
        name: name,
        remoteId: remoteId,
        repliedMessage: repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: size,
        status: status,
        type: MessageType.voice,
        updatedAt: updatedAt,
        duration: duration,
      );

  factory AudioMessage.file(
    File file, {
    required ChatUser author,
    Reaction? reaction,
    required int createdAt,
    required String id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    required int duration,
  }) =>
      AudioFileMessage(
        file,
        author: author,
        createdAt: createdAt,
        id: id,
        reaction: reaction,
        isLoading: isLoading,
        metadata: metadata,
        mimeType: mimeType,
        name: name,
        remoteId: remoteId,
        repliedMessage: repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: size,
        status: status,
        updatedAt: updatedAt,
        duration: duration,
      );

  /// Creates a file message from a map (decoded JSON).
  factory AudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AudioMessageFromJson(json);

  /// Creates a full file message from a partial one.
  factory AudioMessage.fromPartial({
    required ChatUser author,
    required int createdAt,
    required String id,
    bool? isLoading,
    required PartialAudio partialAudio,
    String? remoteId,
    required int duration,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      AudioPathMessage(
        partialAudio.uri,
        author: author,
        createdAt: createdAt,
        id: id,
        isLoading: isLoading,
        metadata: partialAudio.metadata,
        mimeType: partialAudio.mimeType,
        name: partialAudio.name,
        remoteId: remoteId,
        repliedMessage: partialAudio.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialAudio.size,
        status: status,
        type: MessageType.voice,
        updatedAt: updatedAt,
        duration: duration,
      );

  /// Specify whether the message content is currently being loaded.
  final bool? isLoading;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String name;

  final int duration;

  /// Size of the file in bytes.
  final num size;

  /// Equatable props.

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    bool? isLoading,
    Reaction? reaction,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    MessageStatus? status,
    int? updatedAt,
    String? uri,
  });
}

/// A utility class to enable better copyWith.
class AudioPathMessage extends AudioMessage {
  /// The file source (either a remote URL or a local resource).
  final String uri;

  AudioPathMessage(
    this.uri, {
    required ChatUser author,
    Reaction? reaction,
    required int createdAt,
    required String id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    required int duration,
  }) : super(
            author: author,
            id: id,
            name: name,
            duration: duration,
            size: size,
            status: status,
            createdAt: createdAt);

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    dynamic height = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic reaction = _Unset,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    int? duration,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    dynamic width = _Unset,
  }) =>
      AudioPathMessage(
        uri ?? this.uri,
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        duration: duration ?? this.duration,
        reaction: reaction == _Unset ? this.reaction : reaction as Reaction?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as MessageStatus?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );

  @override
  List<Object?> get props => [
        uri,
        author,
        size,
        isLoading,
        duration,
        reaction,
        metadata,
        remoteId,
        roomId,
        showStatus,
        status,
        updatedAt,
        createdAt,
        id
      ];

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$AudioMessageToJson(this);
}

/// A utility class to enable better copyWith.
class AudioFileMessage extends AudioMessage {
  final File file;

  AudioFileMessage(
    this.file, {
    required ChatUser author,
    Reaction? reaction,
    required int createdAt,
    required String id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    MessageStatus? status,
    int? updatedAt,
    required int duration,
  }) : super(
            size: size,
            id: id,
            duration: duration,
            name: name,
            author: author,
            createdAt: createdAt);

  @override
  Message copyWith({
    File? file,
    ChatUser? author,
    int? createdAt,
    dynamic height = _Unset,
    dynamic reaction = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    int? duration,
    dynamic width = _Unset,
  }) =>
      AudioFileMessage(
        file ?? this.file,
        author: author ?? this.author,
        reaction: reaction == _Unset ? this.reaction : reaction as Reaction?,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as MessageStatus?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        duration: duration ?? this.duration,
        size: size ?? this.size,
      );

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => throw UnimplementedError();
}

class _Unset {}
