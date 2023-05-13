import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'message.dart';
import 'user.dart';

part 'room.g.dart';

/// All possible room types.
enum RoomType { channel, direct, group }

/// A class that represents a room where 2 or more participants can chat.
@JsonSerializable()
@immutable
abstract class Room extends Equatable {
  /// Creates a [Room].
  const Room._({
    this.createdAt,
    required this.id,
    this.imageUrl,
    this.lastMessage,
    this.metadata,
    this.name,
    this.description,
    required this.type,
    this.updatedAt,
    required this.users,
  });

  const factory Room({
    int? createdAt,
    String? description,
    required String id,
    String? imageUrl,
    Message? lastMessage,
    Map<String, dynamic>? metadata,
    String? name,
    required RoomType? type,
    int? updatedAt,
    required List<ChatUser> users,
  }) = _Room;

  /// Creates room from a map (decoded JSON).
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Created room timestamp, in ms.
  final int? createdAt;

  /// Room's unique ID.
  final String id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? imageUrl;

  /// List of last messages this room has received.
  final Message? lastMessage;

  /// Additional custom metadata or attributes related to the room.
  final Map<String, dynamic>? metadata;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// [RoomType].
  final RoomType? type;

  /// Updated room timestamp, in ms.
  final int? updatedAt;

  /// List of users which are in the room.
  final List<ChatUser> users;

  /// Description for the Room
  final String? description;

  /// Equatable props.
  @override
  List<Object?> get props => [
        createdAt,
        id,
        imageUrl,
        lastMessage,
        metadata,
        name,
        type,
        updatedAt,
        users,
      ];

  /// Creates a copy of the room with an updated data.
  /// [imageUrl], [name] and [updatedAt] with null values will nullify existing values
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [type] and [users] with null values will be overwritten by previous values.
  Room copyWith({
    int? createdAt,
    String? id,
    String? imageUrl,
    List<Message>? lastMessage,
    Map<String, dynamic>? metadata,
    String? name,
    RoomType? type,
    int? updatedAt,
    List<ChatUser>? users,
  });

  /// Converts room to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

/// A utility class to enable better copyWith.
class _Room extends Room {
  const _Room({
    super.createdAt,
    required super.id,
    super.imageUrl,
    super.lastMessage,
    super.metadata,
    super.name,
    super.description,
    required super.type,
    super.updatedAt,
    required super.users,
  }) : super._();

  @override
  Room copyWith({
    dynamic createdAt = _Unset,
    String? id,
    dynamic imageUrl = _Unset,
    dynamic lastMessage = _Unset,
    dynamic metadata = _Unset,
    dynamic name = _Unset,
    dynamic type = _Unset,
    dynamic description = _Unset,
    dynamic updatedAt = _Unset,
    List<ChatUser>? users,
  }) =>
      _Room(
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        imageUrl: imageUrl == _Unset ? this.imageUrl : imageUrl as String?,
        lastMessage:
            lastMessage == _Unset ? this.lastMessage : lastMessage as Message?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        description:
            description == _Unset ? this.description : description as String?,
        name: name == _Unset ? this.name : name as String?,
        type: type == _Unset ? this.type : type as RoomType?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        users: users ?? this.users,
      );
}

class _Unset {}
