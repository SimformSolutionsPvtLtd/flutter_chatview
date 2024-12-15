// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedReceipt _$UpdatedReceiptFromJson(Map<String, dynamic> json) =>
    UpdatedReceipt(
      id: json['id'] as String,
      newStatus: $enumDecode(_$MessageStatusEnumMap, json['newStatus']),
    );

Map<String, dynamic> _$UpdatedReceiptToJson(UpdatedReceipt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'newStatus': _$MessageStatusEnumMap[instance.newStatus]!,
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
