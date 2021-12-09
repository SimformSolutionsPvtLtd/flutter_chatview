import 'package:flutter/material.dart';

import '../values/typedefs.dart';

class ImageMessageConfiguration {
  final ShareIconConfiguration? shareIconConfig;
  final StringCallback? onTap; // Returns imageURL
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  ImageMessageConfiguration({
    this.shareIconConfig,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.borderRadius,
  });
}

class ShareIconConfiguration {
  final StringCallback? onPressed; // Returns imageURL
  final Widget? icon;
  final Color? defaultIconBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? defaultIconColor;

  ShareIconConfiguration({
    this.onPressed,
    this.icon,
    this.defaultIconBackgroundColor,
    this.padding,
    this.margin,
    this.defaultIconColor,
  });
}
