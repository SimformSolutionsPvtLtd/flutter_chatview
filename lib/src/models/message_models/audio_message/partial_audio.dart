import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../message.dart';
part 'partial_audio.g.dart';

/// A class that represents partial file message.
@JsonSerializable()
@immutable
class PartialAudio {
  /// Creates a partial file message with all variables file can have.
  /// Use [FileMessage] to create a full message.
  /// You can use [FileMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialAudio({
    this.metadata,
    this.mimeType,
    required this.name,
    this.repliedMessage,
    required this.size,
    required this.uri,
  });

  /// Creates a partial file message from a map (decoded JSON).
  factory PartialAudio.fromJson(Map<String, dynamic> json) =>
      _$PartialAudioFromJson(json);

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String name;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// Size of the file in bytes.
  final num size;

  /// The file source (either a remote URL or a local resource).
  final String uri;

  /// Converts a partial file message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialAudioToJson(this);
}
