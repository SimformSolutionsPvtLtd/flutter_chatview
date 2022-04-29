import 'package:flutter/material.dart';
import 'package:chat_view/src/models/reaction_popup_configuration.dart';
import 'package:chat_view/src/utils/constants.dart';

import '../values/typedefs.dart';
import 'emoji_picker_widget.dart';

class EmojiRow extends StatelessWidget {
  EmojiRow({
    Key? key,
    required this.onEmojiTap,
    this.emojiConfiguration,
  }) : super(key: key);

  final StringCallback onEmojiTap;
  final EmojiConfiguration? emojiConfiguration;
  final List<String> _emojiUnicodes = [
    heart,
    faceWithTears,
    astonishedFace,
    disappointedFace,
    angryFace,
    thumbsUp,
  ];

  @override
  Widget build(BuildContext context) {
    final emojiList = emojiConfiguration?.emojiList ?? _emojiUnicodes;
    final size = emojiConfiguration?.size;
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              emojiList.length,
              (index) => GestureDetector(
                onTap: () => onEmojiTap(emojiList[index]),
                child: Text(
                  emojiList[index],
                  style: TextStyle(fontSize: size ?? 28),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.add,
            color: Colors.grey.shade600,
            size: size ?? 28,
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        builder: (context) => EmojiPickerWidget(onSelected: (emoji) {
          Navigator.pop(context);
          onEmojiTap(emoji);
        }),
      );
}
