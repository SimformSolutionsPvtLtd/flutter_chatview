import 'package:chatview/chatview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../message.dart';
import '../user.dart' show ChatUser;
import 'partial_custom.dart';
part 'custom_message.g.dart';

/// A class that represents custom message. Use [metadata] to store anything
/// you want.
@JsonSerializable(explicitToJson: true)
@immutable
abstract class CustomMessage extends Message {
  /// Creates a custom message.
  CustomMessage._({
    required super.author,
    required super.createdAt,
    required super.id,
    super.metadata,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.reaction,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.custom);

  factory CustomMessage({
    required ChatUser author,
    required int createdAt,
    Reaction? reaction,
    required String id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
  }) = _CustomMessage;

  /// Creates a custom message from a map (decoded JSON).
  factory CustomMessage.fromJson(Map<String, dynamic> json) =>
      _$CustomMessageFromJson(json);

  /// Creates a full custom message from a partial one.
  factory CustomMessage.fromPartial({
    required ChatUser author,
    required int createdAt,
    required String id,
    required PartialCustom partialCustom,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    Reaction? reaction,
    int? updatedAt,
  }) =>
      _CustomMessage(
        author: author,
        createdAt: createdAt,
        id: id,
        metadata: partialCustom.metadata,
        remoteId: remoteId,
        reaction: reaction,
        repliedMessage: partialCustom.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        status: status,
        type: MessageType.custom,
        updatedAt: updatedAt,
      );

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
    Reaction? reaction,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  });

  /// Converts a custom message to the map representation,
  /// encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$CustomMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _CustomMessage extends CustomMessage {
  _CustomMessage({
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
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    dynamic reaction,
    dynamic metadata = _Unset,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
  }) =>
      _CustomMessage(
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        reaction: reaction == _Unset ? this.reaction : reaction as Reaction?,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as MessageStatus?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );
}

class _Unset {}
