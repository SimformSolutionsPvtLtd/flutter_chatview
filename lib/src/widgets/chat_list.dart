import 'package:flutter/material.dart';

import 'package:grouped_list/grouped_list.dart';

import 'package:flutter_chat_ui/src/extensions/date_time_extension.dart';
import 'package:flutter_chat_ui/src/models/models.dart';

import 'chat_group_header.dart';
import 'chat_bubble_widget.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
    required this.scrollController,
    required this.messageList,
    required this.currentUser,
    this.showSenderProfileCircle = true,
    this.emojiMessagePadding,
    this.emojiMessageTextStyle,
    this.inComingChatBubble,
    this.outgoingChatBubble,
    this.messageReaction,
    this.imageMessage,
    this.profileCircleConfiguration,
    this.chatBubbleConfiguration,
    this.textMessage,
    ChatListConfiguration? chatListConfiguration,
  })  : chatListConfiguration =
            chatListConfiguration ?? const ChatListConfiguration(),
        super(key: key);

  final ScrollController scrollController;
  final List<Message> messageList;
  final String currentUser;
  final EdgeInsetsGeometry? emojiMessagePadding;
  final TextStyle? emojiMessageTextStyle;
  final ChatBubble? inComingChatBubble;
  final ChatBubble? outgoingChatBubble;
  final MessageReaction? messageReaction;
  final ImageMessage? imageMessage;
  final ProfileCircleConfiguration? profileCircleConfiguration;
  final bool showSenderProfileCircle;
  final ChatBubbleConfiguration? chatBubbleConfiguration;
  final TextMessage? textMessage;
  final ChatListConfiguration chatListConfiguration;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final chatListConfiguration = widget.chatListConfiguration;
    return Container(
      height:
          chatListConfiguration.height ?? MediaQuery.of(context).size.height,
      width: chatListConfiguration.width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: chatListConfiguration.backgroundColor ?? Colors.transparent,
        image: chatListConfiguration.backgroundImage != null
            ? DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(chatListConfiguration.backgroundImage!),
              )
            : null,
      ),
      padding: chatListConfiguration.padding,
      margin: chatListConfiguration.margin,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                GroupedListView<Message, String>(
                  shrinkWrap: true,
                  elements: widget.messageList,
                  groupBy: (element) => element.createdAt.getDateFromDateTime,
                  itemComparator: (message1, message2) =>
                      message1.message.compareTo(message2.message),
                  physics: const NeverScrollableScrollPhysics(),
                  order: chatListConfiguration.order,
                  sort: chatListConfiguration.sort,
                  groupSeparatorBuilder: (separator) => chatListConfiguration
                              .groupSeparatorBuilder !=
                          null
                      ? chatListConfiguration.groupSeparatorBuilder!(separator)
                      : ChatGroupHeader(
                          day: DateTime.parse(separator),
                          chatGroupHeaderPadding:
                              chatListConfiguration.chatGroupHeaderPadding,
                        ),
                  indexedItemBuilder: (context, message, index) =>
                      ChatBubbleWidget(
                    message: message,
                    showSenderProfileCircle: widget.showSenderProfileCircle,
                    inComingChatBubble: widget.inComingChatBubble,
                    outgoingChatBubble: widget.outgoingChatBubble,
                    emojiMessageTextStyle: widget.emojiMessageTextStyle,
                    messageReaction: widget.messageReaction,
                    chatBubbleConfiguration: widget.chatBubbleConfiguration,
                    profileCircleConfiguration:
                        widget.profileCircleConfiguration,
                    isCurrentUser: message.sendBy == widget.currentUser,
                    textMessage: widget.textMessage,
                    emojiMessagePadding: widget.emojiMessagePadding,
                    imageMessage: widget.imageMessage,
                    onLongPress: (yCoordinate) => print("OnLongPress"),
                  ),
                ),
                SizedBox(height: Scaffold.of(context).appBarMaxHeight! / 2.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
