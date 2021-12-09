import 'package:flutter/material.dart';

class ImageMessage {
  final ShareIconConfiguration? shareIcon;
  final void Function()? onImageViewTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  ImageMessage({
    this.shareIcon,
    this.onImageViewTap,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.borderRadius,
  });
}

class ShareIconConfiguration {
  final void Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  ShareIconConfiguration({
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.padding,
    this.margin,
  });
}
