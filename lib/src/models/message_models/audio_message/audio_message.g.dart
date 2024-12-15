// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioMessage _$AudioMessageFromJson(Map<String, dynamic> json) =>
    AudioMessage.network(
      uri: json['uri'] as String,
      author: ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int,
      id: json['id'] as String,
      duration: json['duration'] as int,
      size: json['size'] as num,
      isLoading: json['isLoading'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      reaction: json['reaction'] == null
          ? null
          : Reaction.fromJson(json['reaction'] as Map<String, dynamic>),
      mimeType: json['mimeType'] as String?,
      name: json['name'] as String,
      remoteId: json['remoteId'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String?,
      showStatus: json['showStatus'] as bool?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$AudioMessageToJson(AudioMessage instance) =>
    <String, dynamic>{
      'author': instance.author,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'metadata': instance.metadata,
      'remoteId': instance.remoteId,
      'repliedMessage': instance.repliedMessage,
      'roomId': instance.roomId,
      'showStatus': instance.showStatus,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'updatedAt': instance.updatedAt,
      'reaction': instance.reaction,
      'isLoading': instance.isLoading,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'duration': instance.duration,
      'size': instance.size,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.error: 'error',
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.read: 'read',
  MessageStatus.delivered: 'delivered',
  MessageStatus.undelivered: 'undelivered',
  MessageStatus.pending: 'pending',
  MessageStatus.custom: 'custom',
};

const _$MessageTypeEnumMap = {
  MessageType.custom: 'custom',
  MessageType.image: 'image',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
  MessageType.voice: 'voice',
};
