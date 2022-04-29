import 'package:flutter/material.dart';

import '../../chat_view.dart';
import '../utils/package_strings.dart';
import '../values/typedefs.dart';

class ChatUITextField extends StatelessWidget {
  ChatUITextField({
    Key? key,
    this.sendMessageConfig,
    required this.focusNode,
    required this.textEditingController,
    required this.onPressed,
  }) : super(key: key);
  final SendMessageConfiguration? sendMessageConfig;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final VoidCallBack onPressed;
  final _outLineBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(27),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      style:
          sendMessageConfig?.textStyle ?? const TextStyle(color: Colors.white),
      maxLines: 5,
      minLines: 1,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          color: sendMessageConfig?.defaultSendButtonColor ?? Colors.green,
          onPressed: onPressed,
          icon: sendMessageConfig?.sendButtonIcon ?? const Icon(Icons.send),
        ),
        hintText: sendMessageConfig?.hintText ?? PackageStrings.message,
        fillColor: sendMessageConfig?.textFieldBackgroundColor ?? Colors.white,
        filled: true,
        hintStyle: sendMessageConfig?.hintStyle ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
              letterSpacing: 0.25,
            ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 14,
        ),
        border: _outLineBorder,
        focusedBorder: _outLineBorder,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(29),
        ),
      ),
    );
  }
}
