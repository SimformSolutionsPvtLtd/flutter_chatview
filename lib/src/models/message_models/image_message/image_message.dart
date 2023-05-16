import 'package:chatview/chatview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'partial_image.dart';

part 'image_message.g.dart';

/// A class that represents image message.
@JsonSerializable(explicitToJson: true)
@immutable
abstract class ImageMessage extends Message {
  /// Creates an image message.
  ImageMessage._({
    required super.author,
    required super.createdAt,
    super.reaction,
    this.height,
    required super.id,
    super.metadata,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.updatedAt,
    required this.uri,
    this.width,
  }) : super(type: type ?? MessageType.image);

  factory ImageMessage({
    required ChatUser author,
    required int createdAt,
    Reaction? reaction,
    double? height,
    required String id,
    Map<String, dynamic>? metadata,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    required String uri,
    double? width,
  }) = _ImageMessage;

  /// Creates an image message from a map (decoded JSON).
  factory ImageMessage.fromJson(Map<String, dynamic> json) =>
      _$ImageMessageFromJson(json);

  /// Creates a full image message from a partial one.
  factory ImageMessage.fromPartial({
    required ChatUser author,
    required int createdAt,
    required String id,
    required PartialImage partialImage,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      _ImageMessage(
        author: author,
        createdAt: createdAt,
        height: partialImage.height,
        id: id,
        metadata: partialImage.metadata,
        name: partialImage.name,
        remoteId: remoteId,
        repliedMessage: partialImage.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialImage.size,
        status: status,
        type: MessageType.image,
        updatedAt: updatedAt,
        uri: partialImage.uri,
        width: partialImage.width,
      );

  /// Image height in pixels.
  final double? height;

  /// The name of the image.
  final String name;

  /// Size of the image in bytes.
  final num size;

  /// The image source (either a remote URL or a local resource).
  final String uri;

  /// Image width in pixels.
  final double? width;

  /// Equatable props.
  @override
  List<Object?> get props => [
        author,
        createdAt,
        height,
        id,
        metadata,
        name,
        remoteId,
        repliedMessage,
        roomId,
        size,
        status,
        updatedAt,
        uri,
        width,
      ];

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
    String? name,
    String? remoteId,
    Reaction? reaction,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    MessageStatus? status,
    int? updatedAt,
    String? uri,
    double? width,
  });

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$ImageMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _ImageMessage extends ImageMessage {
  _ImageMessage({
    required super.author,
    required super.createdAt,
    super.height,
    super.reaction,
    required super.id,
    super.metadata,
    required super.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required super.size,
    super.status,
    super.type,
    super.updatedAt,
    required super.uri,
    super.width,
  }) : super._();

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
    String? name,
    String? remoteId,
    Reaction? reaction,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    MessageStatus? status,
    int? updatedAt,
    String? uri,
    double? width,
  }) {
    return _ImageMessage(
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      height: height ?? this.height,
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      name: name ?? this.name,
      remoteId: remoteId ?? this.remoteId,
      reaction: reaction ?? this.reaction,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      roomId: roomId ?? this.roomId,
      showStatus: showStatus ?? this.showStatus,
      size: size ?? this.size,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      uri: uri ?? this.uri,
      width: width ?? this.width,
    );
  }
}
