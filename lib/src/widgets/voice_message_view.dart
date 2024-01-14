import 'package:chatview/chatview.dart';
import 'package:chatview/src/widgets/reaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart' as voice;

class VoiceMessageView extends StatefulWidget {
  const VoiceMessageView({
    Key? key,
    required this.screenWidth,
    required this.message,
    required this.isMessageBySender,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.onMaxDuration,
    this.messageReactionConfig,
    this.config,
  }) : super(key: key);

  /// Provides configuration related to voice message.
  final VoiceMessageConfiguration? config;

  /// Allow user to set width of chat bubble.
  final double screenWidth;

  /// Provides message instance of chat.
  final Message message;
  final Function(int)? onMaxDuration;

  /// Represents current message is sent by current user.
  final bool isMessageBySender;

  /// Provides configuration of reaction appearance in chat bubble.
  final MessageReactionConfiguration? messageReactionConfig;

  /// Provides configuration of chat bubble appearance from other user of chat.
  final ChatBubble? inComingChatBubbleConfig;

  /// Provides configuration of chat bubble appearance from current user of chat.
  final ChatBubble? outgoingChatBubbleConfig;

  @override
  State<VoiceMessageView> createState() => _VoiceMessageViewState();
}

class _VoiceMessageViewState extends State<VoiceMessageView> {
  late voice.VoiceController controller;

  VoiceMessageConfiguration configuration = const VoiceMessageConfiguration();

  @override
  void initState() {
    super.initState();
    controller = voice.VoiceController(
      audioSrc: widget.message.message,
      maxDuration: widget.message.voiceMessageDuration ?? const Duration(seconds: 10),
      isFile: widget.message.message.contains('http') == false,
      onComplete: () {},
      onPause: () {},
      onPlaying: () {},
      onError: (err) {},
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.isMessageBySender
                ? widget.outgoingChatBubbleConfig?.color
                : widget.inComingChatBubbleConfig?.color,
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: widget.message.reaction.reactions.isNotEmpty ? 15 : 0,
          ),
          child: voice.VoiceMessageView(
            controller: controller,
            backgroundColor: (widget.config ?? configuration).backgroundColor,
            circlesColor: (widget.config ?? configuration).circlesColor,
            activeSliderColor: (widget.config ?? configuration).activeSliderColor,
            notActiveSliderColor: (widget.config ?? configuration).notActiveSliderColor,
            innerPadding: (widget.config ?? configuration).innerPadding,
            cornerRadius: (widget.config ?? configuration).cornerRadius,
            size: (widget.config ?? configuration).size,
            circlesTextStyle: (widget.config ?? configuration).circlesTextStyle,
            counterTextStyle: (widget.config ?? configuration).counterTextStyle,
          ),
        ),
        if (widget.message.reaction.reactions.isNotEmpty)
          ReactionWidget(
            isMessageBySender: widget.isMessageBySender,
            reaction: widget.message.reaction,
            messageReactionConfig: widget.messageReactionConfig,
          ),
      ],
    );
  }
}
