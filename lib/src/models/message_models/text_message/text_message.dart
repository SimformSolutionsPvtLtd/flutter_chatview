import 'package:chatview/chatview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'partial_text.dart';
part 'text_message.g.dart';

/// A class that represents text message.
@JsonSerializable(explicitToJson: true)
@immutable
abstract class TextMessage extends Message {
  /// Creates a text message.
  TextMessage._({
    required super.author,
    required super.createdAt,
    required super.id,
    super.reaction,
    super.metadata,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required this.text,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.text);

  factory TextMessage({
    required ChatUser author,
    required String id,
    required int createdAt,
    Reaction? reaction,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    required String text,
    MessageType? type,
    int? updatedAt,
  }) = _TextMessage;

  /// Creates a text message from a map (decoded JSON).
  factory TextMessage.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  /// Creates a full text message from a partial one.
  factory TextMessage.fromPartial({
    required ChatUser author,
    required int createdAt,
    required String id,
    required PartialText partialText,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      _TextMessage(
        author: author,
        createdAt: createdAt,
        id: id,
        metadata: partialText.metadata,
        remoteId: remoteId,
        repliedMessage: partialText.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        status: status,
        text: partialText.text,
        type: MessageType.text,
        updatedAt: updatedAt,
      );

  /// ChatUser's message.
  final String text;

  /// Equatable props.
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        remoteId,
        repliedMessage,
        roomId,
        status,
        text,
        updatedAt,
      ];

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    Reaction? reaction,
    bool? showStatus,
    MessageStatus? status,
    String? text,
    int? updatedAt,
  });

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _TextMessage extends TextMessage {
  _TextMessage({
    required super.author,
    required super.createdAt,
    required super.id,
    super.metadata,
    super.reaction,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required super.text,
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    Reaction? reaction,
    bool? showStatus,
    MessageStatus? status,
    String? text,
    int? updatedAt,
  }) =>
      _TextMessage(
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        metadata: metadata ?? this.metadata,
        reaction: reaction ?? this.reaction,
        remoteId: remoteId ?? this.remoteId,
        repliedMessage: repliedMessage ?? this.repliedMessage,
        roomId: roomId ?? this.roomId,
        showStatus: showStatus ?? this.showStatus,
        status: status ?? this.status,
        text: text ?? this.text,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
