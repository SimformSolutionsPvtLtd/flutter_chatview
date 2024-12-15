// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      createdAt: json['createdAt'] as int?,
      description: json['description'] as String?,
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$RoomTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      users: (json['users'] as List<dynamic>)
          .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'lastMessage': instance.lastMessage,
      'metadata': instance.metadata,
      'name': instance.name,
      'type': _$RoomTypeEnumMap[instance.type],
      'updatedAt': instance.updatedAt,
      'users': instance.users,
      'description': instance.description,
    };

const _$RoomTypeEnumMap = {
  RoomType.channel: 'channel',
  RoomType.direct: 'direct',
  RoomType.group: 'group',
};
