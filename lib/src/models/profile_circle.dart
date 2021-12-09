import 'package:flutter/material.dart';

class ProfileCircleConfiguration {
  final EdgeInsetsGeometry? padding;
  final String? senderProfileImageUrl;
  final double? bottomPadding;
  final double? circleRadius;

  ProfileCircleConfiguration( {
    this.padding,
    this.senderProfileImageUrl,
    this.bottomPadding,
    this.circleRadius,
  });
}
