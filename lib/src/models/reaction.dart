class Reaction {
  Reaction({
    required this.reactions,
    required this.reactedUserIds,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        reactions: json['reactions'],
        reactedUserIds: json['reactedUserIds'],
      );

  final List<String> reactions;
  final List<String> reactedUserIds;

  Map<String, dynamic> toJson() => {
        'reactions': reactions,
        'reactedUserIds': reactedUserIds,
      };
}
