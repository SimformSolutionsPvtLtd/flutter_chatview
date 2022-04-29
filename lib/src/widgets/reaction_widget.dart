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
import 'package:chatview/src/models/message_reaction_configuration.dart';

class ReactionWidget extends StatelessWidget {
  const ReactionWidget({
    Key? key,
    required this.reaction,
    this.messageReactionConfig,
    required this.isMessageBySender,
  }) : super(key: key);
  final String reaction;
  final MessageReactionConfiguration? messageReactionConfig;
  final bool isMessageBySender;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: messageReactionConfig?.padding ??
            const EdgeInsets.symmetric(vertical: 1.7, horizontal: 6),
        margin: messageReactionConfig?.margin ??
            EdgeInsets.only(left: isMessageBySender ? 10 : 16),
        decoration: BoxDecoration(
          color: messageReactionConfig?.backgroundColor ?? Colors.grey.shade200,
          borderRadius:
              messageReactionConfig?.borderRadius ?? BorderRadius.circular(16),
          border: Border.all(
            color: messageReactionConfig?.borderColor ?? Colors.white,
            width: messageReactionConfig?.borderWidth ?? 1,
          ),
        ),
        child: Text(
          reaction,
          style: TextStyle(fontSize: messageReactionConfig?.reactionSize ?? 13),
        ),
      ),
    );
  }
}
