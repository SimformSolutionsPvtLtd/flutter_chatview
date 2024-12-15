import 'package:chatview/src/models/models.dart';
import 'package:chatview/src/values/enumaration.dart';
import 'package:flutter/material.dart';

class WidgetsExtension {
  WidgetsExtension({required this.messageTypes});

  final List<NewMessageSupport> messageTypes;
}

abstract class NewMessageSupport {
  NewMessageSupport(
    this.messageClass, {
    required this.messageBuilder,
    required this.messageType,
    required this.title,
    required this.replyPreview,
    this.icon,
    this.priority = ToolBarPriority.medium,
    this.customToolBarWidget,
    this.isInsideBubble = true,
  });

  final Message messageClass;
  final String messageType;
  final Widget Function(Message message) messageBuilder;
  final Icon? icon;
  final String title;
  final Widget? customToolBarWidget;
  final Widget replyPreview;
  final ToolBarPriority priority;
  final bool isInsideBubble;
}
