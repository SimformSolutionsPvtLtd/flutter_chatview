// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) => Reaction(
      reactions:
          (json['reactions'] as List<dynamic>).map((e) => e as String).toList(),
      reactedUserIds: (json['reactedUserIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'reactions': instance.reactions,
      'reactedUserIds': instance.reactedUserIds,
    };
