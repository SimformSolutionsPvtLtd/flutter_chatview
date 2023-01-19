import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

class ChatViewInheritedWidget extends InheritedWidget {
  const ChatViewInheritedWidget({
    Key? key,
    required Widget child,
    required this.featureActiveConfig,
    required this.chatController,
  }) : super(key: key, child: child);
  final FeatureActiveConfig featureActiveConfig;
  final ChatController chatController;

  static ChatViewInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ChatViewInheritedWidget>();

  @override
  bool updateShouldNotify(covariant ChatViewInheritedWidget oldWidget) =>
      oldWidget.featureActiveConfig != featureActiveConfig;
}
