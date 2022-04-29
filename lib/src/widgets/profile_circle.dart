import 'package:flutter/material.dart';
import 'package:chat_view/src/utils/constants.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    Key? key,
    required this.bottomPadding,
    this.imageUrl,
    this.profileCirclePadding,
    this.circleRadius,
  }) : super(key: key);
  final double bottomPadding;
  final String? imageUrl;
  final EdgeInsetsGeometry? profileCirclePadding;
  final double? circleRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: profileCirclePadding ??
          EdgeInsets.only(left: 6.0, right: 4, bottom: bottomPadding),
      child: CircleAvatar(
        radius: circleRadius ?? 16,
        backgroundImage: NetworkImage(imageUrl ?? profileImage),
      ),
    );
  }
}
