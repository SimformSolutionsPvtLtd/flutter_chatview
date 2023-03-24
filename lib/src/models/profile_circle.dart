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

class ProfileCircleConfiguration {
  /// Used to give padding to profile circle.
  final EdgeInsetsGeometry? padding;

  /// Provides image url of user
  final String? profileImageUrl;

  /// Used for give bottom padding to profile circle
  final double? bottomPadding;

  /// Used for give circle radius to profile circle
  final double? circleRadius;

  /// Provides callback when user tap on profile circle.
  final void Function(ChatUser)? onAvatarTap;

  /// Provides callback when user long press on profile circle.
  final void Function(ChatUser)? onAvatarLongPress;

  const ProfileCircleConfiguration({
    this.onAvatarTap,
    this.padding,
    this.profileImageUrl,
    this.bottomPadding,
    this.circleRadius,
    this.onAvatarLongPress,
  });
}
