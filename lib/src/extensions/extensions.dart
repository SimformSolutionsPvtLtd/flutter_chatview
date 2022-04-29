import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_view/src/values/enumaration.dart';
import '../utils/constants.dart';
import '../utils/package_strings.dart';

extension TimeDifference on DateTime {
  String get getDay {
    final DateTime formattedDate = DateFormat(dateFormat).parse(toString());
    final DateFormat formatter = DateFormat.yMMMMd(en_us);
    final differenceInDays = formattedDate.difference(DateTime.now()).inDays;
    if (differenceInDays == 0) {
      return PackageStrings.today;
    } else if (differenceInDays <= 1 && differenceInDays >= -1) {
      return PackageStrings.yesterday;
    } else {
      return formatter.format(formattedDate);
    }
  }

  String get getDateFromDateTime {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String get getTimeFromDateTime => DateFormat.Hm().format(this);
}

extension ValidateString on String {
  bool get isImageUrl {
    final imageUrlRegExp = RegExp(imageUrlRegExpression);
    return imageUrlRegExp.hasMatch(this) || startsWith('data:image');
  }

  bool get fromMemory => startsWith('data:image');

  bool get isEmoji {
    final emojiRegExp = RegExp(emojiRegExpression);
    return emojiRegExp.hasMatch(this);
  }

  bool get isUrl => Uri.tryParse(this)?.isAbsolute ?? false;
}

extension MessageTypes on MessageType {
  bool get isImage => this == MessageType.image;

  bool get isText => this == MessageType.text;
}

extension ConnectionStates on ConnectionState {
  bool get isWaiting => this == ConnectionState.waiting;

  bool get isActive => this == ConnectionState.active;
}
