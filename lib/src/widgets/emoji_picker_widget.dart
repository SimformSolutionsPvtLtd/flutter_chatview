import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../values/typedefs.dart';

class EmojiPickerWidget extends StatelessWidget {
  const EmojiPickerWidget({Key? key, required this.onSelected})
      : super(key: key);

  final StringCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: 35,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Expanded(
            child: EmojiPicker(
              onEmojiSelected: (Category category, Emoji emoji) =>
                  onSelected(emoji.emoji),
              config: Config(
                columns: 7,
                emojiSizeMax: 32 * ((!kIsWeb && Platform.isIOS) ? 1.30 : 1.0),
                initCategory: Category.RECENT,
                bgColor: Colors.white,
                showRecentsTab: false,
                recentsLimit: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
