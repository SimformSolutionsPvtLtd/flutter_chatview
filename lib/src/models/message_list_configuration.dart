import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../values/typedefs.dart';
import 'send_message_configuration.dart';

class ChatBackgroundConfiguration {
  final Color? backgroundColor;
  final String? backgroundImage;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final GroupedListOrder groupedListOrder;
  final bool sortEnable;
  final bool horizontalDragToShowMessageTime;
  final TextStyle? messageTimeTextStyle;
  final Color? messageTimeIconColor;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;
  final Widget? loadingWidget;

  const ChatBackgroundConfiguration({
    this.defaultGroupSeparatorConfig,
    this.backgroundColor,
    this.backgroundImage,
    this.height,
    this.width,
    this.groupSeparatorBuilder,
    this.groupedListOrder = GroupedListOrder.ASC,
    this.sortEnable = false,
    this.horizontalDragToShowMessageTime = true,
    this.padding,
    this.margin,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
    this.loadingWidget,
  });
}

class DefaultGroupSeparatorConfiguration {
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  DefaultGroupSeparatorConfiguration({
    this.padding,
    this.textStyle,
  });
}
