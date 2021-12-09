import 'package:flutter/material.dart';

import 'package:chat_view/src/utils/package_strings.dart';

import '../values/typedefs.dart';

class ReplyPopupWidget extends StatelessWidget {
  const ReplyPopupWidget({
    Key? key,
    required this.sendByCurrentUser,
    required this.onUnsendTap,
    required this.onReplyTap,
    required this.onReportTap,
    required this.onMoreTap,
    this.buttonTextStyle,
    this.topBorderColor,
  }) : super(key: key);

  final bool sendByCurrentUser;
  final VoidCallBack onUnsendTap;
  final VoidCallBack onReplyTap;
  final VoidCallBack onReportTap;
  final VoidCallBack onMoreTap;
  final TextStyle? buttonTextStyle;
  final Color? topBorderColor;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        buttonTextStyle ?? const TextStyle(fontSize: 14, color: Colors.black);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceWidth > 500 ? deviceWidth * 0.05 : deviceWidth * 0.13,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: topBorderColor ?? Colors.grey.shade400, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onReplyTap,
            child: Text(
              PackageStrings.reply,
              style: textStyle,
            ),
          ),
          if (sendByCurrentUser)
            InkWell(
              onTap: onUnsendTap,
              child: Text(
                PackageStrings.unsend,
                style: textStyle,
              ),
            ),
          InkWell(
            onTap: onMoreTap,
            child: Text(
              PackageStrings.more,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
