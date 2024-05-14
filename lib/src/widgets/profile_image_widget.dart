import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../values/typedefs.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.isNetworkImage = true,
    this.defaultAvatarImage = profileImage,
    this.circleRadius,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
  });

  /// Allow user to set radius of circle avatar.
  final double? circleRadius;

  /// Allow user to pass image url of user's profile picture.
  final String? imageUrl;

  /// Flag to check whether image is network or asset
  final bool isNetworkImage;

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
      child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: imageUrl ?? defaultAvatarImage,
              height: (circleRadius ?? 20) * 2,
              width: (circleRadius ?? 20) * 2,
              fit: BoxFit.cover,
              errorWidget: networkImageErrorBuilder ?? _networkImageErrorWidget,
            )
          : Image.asset(
              imageUrl ?? defaultAvatarImage,
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
