import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

import '../models/cupertino_widget_configuration.dart';

/// This widget for alternative of excessive amount of passing arguments
/// over widgets.
///
@immutable
class ChatViewInheritedWidget extends InheritedWidget {
  ChatViewInheritedWidget({
    Key? key,
    required Widget child,
    required this.featureActiveConfig,
    required this.chatController,
    required this.currentUser,
    required this.isCupertinoApp,
    this.cupertinoWidgetConfig,
  }) : super(key: key, child: child);

  final FeatureActiveConfig featureActiveConfig;
  final ChatController chatController;
  final ChatUser currentUser;
  final CupertinoWidgetConfiguration? cupertinoWidgetConfig;
  final bool isCupertinoApp;

  /// for appBar

  static ChatViewInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ChatViewInheritedWidget>();

  @override
  bool updateShouldNotify(covariant ChatViewInheritedWidget oldWidget) =>
      oldWidget.featureActiveConfig != featureActiveConfig;
}
