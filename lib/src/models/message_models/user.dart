import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// All possible roles user can have.
enum Role { admin, agent, moderator, user }

/// A class that represents user.
@JsonSerializable()
@immutable
abstract class ChatUser extends Equatable {
  /// Creates a user.
  const ChatUser._({
    this.createdAt,
    this.firstName,
    required this.id,
    this.imageUrl,
    this.lastName,
    this.lastSeen,
    this.metadata,
    this.role,
    this.updatedAt,
  });

  const factory ChatUser({
    int? createdAt,
    String? firstName,
    required String id,
    String? imageUrl,
    String? lastName,
    int? lastSeen,
    Map<String, dynamic>? metadata,
    Role? role,
    int? updatedAt,
  }) = _User;

  /// Creates user from a map (decoded JSON).
  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);

  /// Created user timestamp, in ms.
  final int? createdAt;

  /// First name of the user.
  final String? firstName;

  /// Unique ID of the user.
  final String id;

  /// Remote image URL representing user's avatar.
  final String? imageUrl;

  /// Last name of the user.
  final String? lastName;

  /// Timestamp when user was last visible, in ms.
  final int? lastSeen;

  /// Additional custom metadata or attributes related to the user.
  final Map<String, dynamic>? metadata;

  /// ChatUser [Role].
  final Role? role;

  /// Updated user timestamp, in ms.
  final int? updatedAt;

  /// Equatable props.
  @override
  List<Object?> get props => [
        createdAt,
        firstName,
        id,
        imageUrl,
        lastName,
        lastSeen,
        metadata,
        role,
        updatedAt,
      ];

  ChatUser copyWith({
    int? createdAt,
    String? firstName,
    String? id,
    String? imageUrl,
    String? lastName,
    int? lastSeen,
    Map<String, dynamic>? metadata,
    Role? role,
    int? updatedAt,
  });

  /// Converts user to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}

/// A utility class to enable better copyWith.
class _User extends ChatUser {
  const _User({
    super.createdAt,
    super.firstName,
    required super.id,
    super.imageUrl,
    super.lastName,
    super.lastSeen,
    super.metadata,
    super.role,
    super.updatedAt,
  }) : super._();

  @override
  ChatUser copyWith({
    dynamic createdAt = _Unset,
    dynamic firstName = _Unset,
    String? id,
    dynamic imageUrl = _Unset,
    dynamic lastName = _Unset,
    dynamic lastSeen = _Unset,
    dynamic metadata = _Unset,
    dynamic role = _Unset,
    dynamic updatedAt = _Unset,
  }) =>
      _User(
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        firstName: firstName == _Unset ? this.firstName : firstName as String?,
        id: id ?? this.id,
        imageUrl: imageUrl == _Unset ? this.imageUrl : imageUrl as String?,
        lastName: lastName == _Unset ? this.lastName : lastName as String?,
        lastSeen: lastSeen == _Unset ? this.lastSeen : lastSeen as int?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        role: role == _Unset ? this.role : role as Role?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );
}

class _Unset {}
