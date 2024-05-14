import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiPickerSheetConfig {
  /// Configuration for emoji picker
  const EmojiPickerSheetConfig({
    this.columns = 7,
    this.initCategory = Category.RECENT,
    this.backgroundColor = Colors.white,
    this.recentTabBehavior = RecentTabBehavior.NONE,
    this.recentLimit = 28,
    this.emojiSizeMax,
  });

  final int columns;
  final double? emojiSizeMax;
  final Category initCategory;
  final Color backgroundColor;
  final int recentLimit;
  final RecentTabBehavior recentTabBehavior;
}
