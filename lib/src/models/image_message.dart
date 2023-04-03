import 'package:flutter/material.dart';

import '../values/typedefs.dart';

class ImageMessageConfiguration {
  /// Provides configuration of share button while image message is appeared.
  final ShareIconConfiguration? shareIconConfig;

  /// Provides callback when user taps on image message.
  final StringCallback? onTap;

  /// Used for giving height of image message.
  final double? height;

  /// Used for giving width of image message.
  final double? width;

  /// Used for giving padding of image message.
  final EdgeInsetsGeometry? padding;

  /// Used for giving margin of image message.
  final EdgeInsetsGeometry? margin;

  /// Used for giving border radius of image message.
  final BorderRadius? borderRadius;

  const ImageMessageConfiguration({
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
  /// Provides callback when user press on share button.
  final StringCallback? onPressed; // Returns imageURL

  /// Provides ability to add custom share icon.
  final Widget? icon;

  /// Used to give share icon background color.
  final Color? defaultIconBackgroundColor;

  /// Used to give share icon padding.
  final EdgeInsetsGeometry? padding;

  /// Used to give share icon margin.
  final EdgeInsetsGeometry? margin;

  /// Used to give share icon color.
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
