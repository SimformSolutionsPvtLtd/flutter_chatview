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
import 'package:flutter/material.dart';

import '../../chatview.dart';
import '../utils/package_strings.dart';

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
