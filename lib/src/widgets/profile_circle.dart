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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    Key? key,
    required this.bottomPadding,
    this.imageUrl,
    this.profileCirclePadding,
    this.circleRadius,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  /// Allow users to give  default bottom padding according to user case.
  final double bottomPadding;

  /// Allow user to pass image url of user's profile picture.
  final String? imageUrl;

  /// Allow user to set whole padding of profile circle view.
  final EdgeInsetsGeometry? profileCirclePadding;

  /// Allow user to set radius of circle avatar.
  final double? circleRadius;

  /// Allow user to do operation when user tap on profile circle.
  final VoidCallback? onTap;

  /// Allow user to do operation when user long press on profile circle.
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl ?? profileImage;

    var cacheKey = imageUrl ?? '';
    if (cacheKey.contains('amazonaws')) {
      cacheKey = cacheKey.split('?').first;
    }

    return Padding(
      padding: profileCirclePadding ?? EdgeInsets.only(left: 6.0, right: 4, bottom: bottomPadding),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: CircleAvatar(
            radius: circleRadius ?? 16,
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: url,
              cacheKey: cacheKey,
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circleRadius ?? 16),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              )),
              progressIndicatorBuilder: (context, url, loadingProgress) {
                if (loadingProgress.totalSize == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.downloaded / (loadingProgress.totalSize ?? 0),
                  ),
                );
              },
            )),
      ),
    );
  }
}
