import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior({
    this.bottomPadding = 0,
  });

  /// The amount of space the scrollbar should have before reaching the bottom.
  final double bottomPadding;

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        assert(details.controller != null);
        return RawScrollbar(
          padding: EdgeInsets.only(
            bottom: bottomPadding,
          ),
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return super.buildScrollbar(context, child, details);
    }
  }
}
