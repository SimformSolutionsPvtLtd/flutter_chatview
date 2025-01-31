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

import '../../utils/constants/constants.dart';
import '../../values/enumeration.dart';
import '../../values/typedefs.dart';

class ChatUser {
  static const String TYPE_USER = 'user';
  static const String TYPE_ADMIN = 'admin';
  static const String TYPE_BOT = 'bot';

  /// Provides id of user.
  final String id;

  /// Provides name of user.
  final String name;

  // Provides title of user
  final String? title;

  /// Provides profile picture as network URL or asset of user.
  /// Or
  /// Provides profile picture's data in base64 string.
  final String? profilePhoto;

  /// Provides emoji of user
  final String? emoji;

  /// Provides introduction of user
  final String? introduction;

  /// Provides createdAt of user
  final DateTime? createdAt;

  /// Provides senderType of user
  final String? type;

  /// Field to set default image if network url for profile image not provided
  final String defaultAvatarImage;

  /// Field to define image type [network, asset or base64]
  final ImageType imageType;

  /// Error builder to build error widget for asset image
  final AssetImageErrorBuilder? assetImageErrorBuilder;

  /// Error builder to build error widget for network image
  final NetworkImageErrorBuilder? networkImageErrorBuilder;

  /// Progress indicator builder for network image
  final NetworkImageProgressIndicatorBuilder?
      networkImageProgressIndicatorBuilder;

  ChatUser({
    required this.id,
    required this.name,
    this.title,
    this.profilePhoto,
    this.emoji,
    this.introduction,
    this.createdAt,
    this.type,
    this.defaultAvatarImage = profileImage,
    this.imageType = ImageType.network,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
    this.networkImageProgressIndicatorBuilder,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        profilePhoto: json["profilePhoto"],
        emoji: json["emoji"],
        introduction: json["introduction"],
        createdAt: json["createdAt"],
        type: json["type"],
        imageType: ImageType.tryParse(json['imageType']?.toString()) ??
            ImageType.network,
        defaultAvatarImage: json["defaultAvatarImage"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'profilePhoto': profilePhoto,
        'emoji': emoji,
        'introduction': introduction,
        'imageType': imageType.name,
        'createdAt': createdAt,
        'defaultAvatarImage': defaultAvatarImage,
        'type': type,
      };

  ChatUser copyWith({
    String? id,
    String? name,
    String? profilePhoto,
    String? title,
    String? emoji,
    String? introduction,
    ImageType? imageType,
    DateTime? createdAt,
    String? defaultAvatarImage,
    String? type,
    bool forceNullValue = false,
  }) {
    return ChatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      introduction: introduction ?? this.introduction,
      imageType: imageType ?? this.imageType,
      createdAt: createdAt ?? this.createdAt,
      profilePhoto:
          forceNullValue ? profilePhoto : profilePhoto ?? this.profilePhoto,
      defaultAvatarImage: defaultAvatarImage ?? this.defaultAvatarImage,
      type: type ?? this.type,
    );
  }
}
