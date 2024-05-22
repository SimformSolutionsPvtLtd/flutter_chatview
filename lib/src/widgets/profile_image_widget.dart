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

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.defaultAvatarImage = profileImage,
    this.circleRadius,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
    this.imageType = ImageType.network,
  });

  /// Allow user to set radius of circle avatar.
  final double? circleRadius;

  /// Allow user to pass image url of user's profile picture.
  final String? imageUrl;

  /// Flag to check whether image is network or asset
  final ImageType? imageType;

  /// Field to set default avatar image if profile image link not provided
  final String defaultAvatarImage;

  /// Error builder to build error widget for asset image
  final AssetImageErrorBuilder? assetImageErrorBuilder;

  /// Error builder to build error widget for network image
  final NetworkImageErrorBuilder? networkImageErrorBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circleRadius ?? 20),
      child: ((imageType?.isBase64 ?? false) && imageUrl != null)
          ? Image.memory(
              base64Decode(imageUrl!),
              height: (circleRadius ?? 20) * 2,
              width: (circleRadius ?? 20) * 2,
              fit: BoxFit.cover,
            )
          : (imageType?.isNetwork ?? true)
              ? CachedNetworkImage(
                  imageUrl: imageUrl ?? defaultAvatarImage,
                  height: (circleRadius ?? 20) * 2,
                  width: (circleRadius ?? 20) * 2,
                  fit: BoxFit.cover,
                  errorWidget:
                      networkImageErrorBuilder ?? _networkImageErrorWidget,
                )
              : Image.asset(
                  imageUrl ?? '',
                  height: (circleRadius ?? 20) * 2,
                  width: (circleRadius ?? 20) * 2,
                  fit: BoxFit.cover,
                  errorBuilder: assetImageErrorBuilder ?? _errorWidget,
                ),
    );
  }

  Widget _networkImageErrorWidget(context, url, error) {
    return const Center(
      child: Icon(
        Icons.error_outline,
      ),
    );
  }

  Widget _errorWidget(context, error, stackTrace) {
    return const Center(
      child: Icon(
        Icons.error_outline,
      ),
    );
  }
}
