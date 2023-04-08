import 'package:json_annotation/json_annotation.dart';
part 'reaction.g.dart';

@JsonSerializable(explicitToJson: true)
               
class Reaction{
  Reaction({
    required this.reactions,
    required this.reactedUserIds,
  });
  
  /// Provides list of reaction in single message.
  final List<String> reactions;

  /// Provides list of user who reacted on message.
  final List<String> reactedUserIds;


    /// Creates a text message from a map (decoded JSON).
  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);

}
