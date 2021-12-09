import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatListConfiguration {
  final Color? backgroundColor;
  final String? backgroundImage;
  final EdgeInsetsGeometry? chatGroupHeaderPadding;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final Widget Function(String separator)? groupSeparatorBuilder;
  final GroupedListOrder order;
  final bool sort;
  final bool horizontalDragToShowTime;

  const ChatListConfiguration({
    this.backgroundColor,
    this.backgroundImage,
    this.chatGroupHeaderPadding,
    this.height,
    this.width,
    this.groupSeparatorBuilder,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.horizontalDragToShowTime = true,
    this.padding,
    this.margin,
  });
}
