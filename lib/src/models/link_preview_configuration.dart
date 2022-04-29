import 'package:flutter/material.dart';

class LinkPreviewConfiguration {
  final Color? backgroundColor;
  final double? borderRadius;
  final TextStyle? bodyStyle;
  final TextStyle? titleStyle;
  final TextStyle? linkStyle;
  final Color? loadingColor;
  final EdgeInsetsGeometry? padding;

  LinkPreviewConfiguration({
    this.loadingColor,
    this.backgroundColor,
    this.borderRadius,
    this.bodyStyle,
    this.titleStyle,
    this.linkStyle,
    this.padding,
  });
}
