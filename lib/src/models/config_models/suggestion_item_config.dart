import '../../values/typedefs.dart';
import 'package:flutter/material.dart';

class SuggestionItemConfig {
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final SuggestionItemBuilder? customItemBuilder;

  const SuggestionItemConfig({
    this.decoration,
    this.padding,
    this.textStyle,
    this.customItemBuilder,
  });
}
