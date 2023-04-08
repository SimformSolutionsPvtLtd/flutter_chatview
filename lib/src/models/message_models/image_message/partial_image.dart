import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import 'image_message.dart';

part 'partial_image.g.dart';

/// A class that represents partial image message.
@JsonSerializable()
@immutable
class PartialImage {
  /// Creates a partial image message with all variables image can have.
  /// Use [ImageMessage] to create a full message.
  /// You can use [ImageMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialImage({
    this.height,
    this.metadata,
    required this.name,
    this.repliedMessage,
    required this.size,
    required this.uri,
    this.width,
  });

  /// Creates a partial image message from a map (decoded JSON).
  factory PartialImage.fromJson(Map<String, dynamic> json) =>
      _$PartialImageFromJson(json);

  /// Image height in pixels.
  final double? height;

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// The name of the image.
  final String name;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// Size of the image in bytes.
  final num size;

  /// The image source (either a remote URL or a local resource).
  final String uri;

  /// Image width in pixels.
  final double? width;

  /// Converts a partial image message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialImageToJson(this);
}
