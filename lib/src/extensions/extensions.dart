/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'package:chatview/chatview.dart';
import 'package:chatview/src/inherited_widgets/configurations_inherited_widgets.dart';
import 'package:chatview/src/widgets/chat_view_inherited_widget.dart';
import 'package:chatview/src/widgets/profile_image_widget.dart';
import 'package:chatview/src/widgets/suggestions/suggestions_config_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants/constants.dart';
import '../utils/emoji_parser.dart';
import '../utils/package_strings.dart';

/// Extension for DateTime to get specific formats of dates and time.
extension TimeDifference on DateTime {
  String getDay(String chatSeparatorDatePattern) {
    final now = DateTime.now();

    /// Compares only the year, month, and day of the dates, ignoring the time.
    /// For example, `2024-12-09 22:00` and `2024-12-10 00:05` are on different
    /// calendar days but less than 24 hours apart. This ensures the difference
    /// is based on the date, not the total hours between the timestamps.
    final targetDate = DateTime(year, month, day);
    final currentDate = DateTime(now.year, now.month, now.day);

    final differenceInDays = currentDate.difference(targetDate).inDays;

    if (differenceInDays == 0) {
      return PackageStrings.today;
    } else if (differenceInDays <= 1 && differenceInDays >= -1) {
      return PackageStrings.yesterday;
    } else {
      final DateFormat formatter = DateFormat(chatSeparatorDatePattern);
      return formatter.format(this);
    }
  }

  String get getDateFromDateTime {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String get getTimeFromDateTime => DateFormat.Hm().format(this);
}

/// Extension on String which implements different types string validations.
extension ValidateString on String {
  bool get isImageUrl {
    final imageUrlRegExp = RegExp(imageUrlRegExpression);
    return imageUrlRegExp.hasMatch(this) || startsWith('data:image');
  }

  bool get fromMemory => startsWith('data:image');

  bool get isAllEmoji {
    for (String s in EmojiParser().unemojify(this).split(" ")) {
      if (!s.startsWith(":") || !s.endsWith(":")) {
        return false;
      }
    }
    return true;
  }

  bool get isUrl => Uri.tryParse(this)?.isAbsolute ?? false;

  Widget getUserProfilePicture({
    required ChatUser? Function(String) getChatUser,
    double? profileCircleRadius,
    EdgeInsets? profileCirclePadding,
  }) {
    final user = getChatUser(this);
    return Padding(
      padding: profileCirclePadding ?? const EdgeInsets.only(left: 4),
      child: ProfileImageWidget(
        imageUrl: user?.profilePhoto,
        imageType: user?.imageType,
        defaultAvatarImage: user?.defaultAvatarImage ?? profileImage,
        circleRadius: profileCircleRadius ?? 8,
        assetImageErrorBuilder: user?.assetImageErrorBuilder,
        networkImageErrorBuilder: user?.networkImageErrorBuilder,
        networkImageProgressIndicatorBuilder:
            user?.networkImageProgressIndicatorBuilder,
      ),
    );
  }
}

/// Extension on MessageType for checking specific message type
extension MessageTypes on MessageType {
  bool get isImage => this == MessageType.image;

  bool get isText => this == MessageType.text;

  bool get isVoice => this == MessageType.voice;

  bool get isCustom => this == MessageType.custom;
}

/// Extension on ConnectionState for checking specific connection.
extension ConnectionStates on ConnectionState {
  bool get isWaiting => this == ConnectionState.waiting;

  bool get isActive => this == ConnectionState.active;
}

/// Extension on nullable sting to return specific state string.
extension ChatViewStateTitleExtension on String? {
  String getChatViewStateTitle(ChatViewState state) {
    switch (state) {
      case ChatViewState.hasMessages:
        return this ?? '';
      case ChatViewState.noData:
        return this ?? 'No Messages';
      case ChatViewState.loading:
        return this ?? '';
      case ChatViewState.error:
        return this ?? 'Something went wrong !!';
    }
  }
}

/// Extension on State for accessing inherited widget.
extension StatefulWidgetExtension on State {
  ChatViewInheritedWidget? get chatViewIW =>
      context.mounted ? ChatViewInheritedWidget.of(context) : null;

  ReplySuggestionsConfig? get suggestionsConfig => context.mounted
      ? SuggestionsConfigIW.of(context)?.suggestionsConfig
      : null;

  ConfigurationsInheritedWidget get chatListConfig =>
      context.mounted && ConfigurationsInheritedWidget.of(context) != null
          ? ConfigurationsInheritedWidget.of(context)!
          : const ConfigurationsInheritedWidget(
              chatBackgroundConfig: ChatBackgroundConfiguration(),
              child: SizedBox.shrink(),
            );
}

/// Extension on State for accessing inherited widget.
extension BuildContextExtension on BuildContext {
  ChatViewInheritedWidget? get chatViewIW =>
      mounted ? ChatViewInheritedWidget.of(this) : null;

  ReplySuggestionsConfig? get suggestionsConfig =>
      mounted ? SuggestionsConfigIW.of(this)?.suggestionsConfig : null;

  ConfigurationsInheritedWidget get chatListConfig =>
      mounted && ConfigurationsInheritedWidget.of(this) != null
          ? ConfigurationsInheritedWidget.of(this)!
          : const ConfigurationsInheritedWidget(
              chatBackgroundConfig: ChatBackgroundConfiguration(),
              child: SizedBox.shrink(),
            );

  ChatBubbleConfiguration? get chatBubbleConfig =>
      chatListConfig.chatBubbleConfig;
}
