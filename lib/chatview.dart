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

/// # `flutter_chatbook` - Rapidly Create Flutter Chat Apps

/// flutter_chatbook is a powerful Flutter package designed to accelerate the development of chat applications. With flutter_chatbook, you can create feature-rich chat apps in minutes, enabling seamless communication and collaboration between users.

/// ## Key Features

/// - **Plugin System**: flutter_chatbook provides a flexible plugin system that allows you to extend the functionality of your chat app. Easily integrate plugins for additional features such as file sharing, voice messaging, or chatbots.
/// - **Plugin Marketplace**: Discover and utilize a wide range of pre-built plugins from the flutter_chatbook Plugin Marketplace. Quickly enhance your chat app by integrating popular and customizable plugins from a centralized repository.
/// - **Real-Time UI Updates**: Ensure real-time updates in the user interface to deliver a dynamic chat experience. Users can see new messages, typing indicators, and other relevant updates in real-time without the need for manual refreshing.
/// - **User Authentication**: Implement user authentication functionality, allowing users to register, log in, and manage their profiles securely.
/// - **Group Chats**: Enable users to participate in group conversations, fostering collaboration and interaction among multiple participants.
/// - **Message Formatting**: Provide users with rich text formatting options, including text styling, emojis, attachments, and more, to enhance their messaging experience.
/// - **Customization**: Customize the look and feel of your chat app with ease. Modify themes, color schemes, fonts, and other visual elements to match your branding and design preferences.

library chatview;

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chatview/src/controller/chat_view_controller.dart';
import 'package:chatview/src/models/voice_message_configuration.dart';
import 'package:chatview/src/utils/debounce.dart';
import 'package:chatview/src/values/custom_time_messages.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as picker;
import 'package:flutter/foundation.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'src/extensions/extension_apis/service/chat_database_service.dart';
import 'src/extensions/input_textfield_controller.dart';
import 'src/models/cupertino_widget_configuration.dart';
import 'src/models/cupertino_widget_model/cupertino_context.dart';
import 'src/models/pattern_style.dart';
import 'src/utils/measure_size.dart';
import 'src/utils/package_strings.dart';
import 'src/values/enumaration.dart';
import 'src/values/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'dart:io' if (kIsWeb) 'dart:html';
import './src/models/models.dart';
import 'src/utils/constants/constants.dart';
import 'src/wrappers/condition_wrapper.dart';
import 'src/extensions/extensions.dart';
import 'src/wrappers/material_conditional_wrapper.dart';

export 'src/models/models.dart';
export 'src/values/enumaration.dart';
export 'src/values/typedefs.dart';
export 'package:audio_waveforms/audio_waveforms.dart'
    show WaveStyle, PlayerWaveStyle;
export 'src/models/receipts_widget_config.dart';
export 'src/extensions/extensions.dart' show MessageTypes;
export 'src/extensions/extension_apis/default plugins/exports.dart';
export 'src/controller/chat_view_controller.dart';
export 'src/extensions/extension_apis/chat_view_extension.dart';
export 'src/extensions/extension_apis/service/service_export.dart';

part './src/controller/chat_controller.dart';
part './src/widgets/chat_bubble_widget.dart';
part './src/widgets/chat_group_header.dart';
part './src/widgets/chat_groupedlist_widget.dart';
part './src/widgets/chat_list_widget.dart';
part './src/widgets/chat_message_sending_to_sent_animation.dart';
part 'src/widgets/chat_view.dart';
part 'src/widgets/chat_view_appbar.dart';
part 'src/widgets/chat_view_inherited_widget.dart';
part 'src/widgets/chatui_textfield.dart';
part 'src/widgets/chatview_state_widget.dart';
part 'src/widgets/default_reaction_popup_widget.dart';
part 'src/widgets/emoji_picker_widget.dart';
part 'src/widgets/emoji_row.dart';
part 'src/widgets/glassmorphism_reaction_popup.dart';
part 'src/widgets/image_message_view.dart';
part 'src/widgets/link_preview.dart';
part 'src/widgets/message_time_widget.dart';
part 'src/widgets/message_view.dart';
part 'src/wrappers/cupertino_menu_wrapper.dart';
part 'src/widgets/profile_circle.dart';
part 'src/widgets/reaction_popup.dart';
part 'src/widgets/reaction_widget.dart';
part 'src/widgets/reactions_bottomsheet.dart';
part 'src/widgets/reply_icon.dart';
part 'src/widgets/reply_message_widget.dart';
part 'src/widgets/reply_popup_widget.dart';
part 'src/widgets/send_message_widget.dart';
part 'src/widgets/share_icon.dart';
part 'src/widgets/swipe_to_reply.dart';
part 'src/widgets/text_message_view.dart';
part 'src/widgets/type_indicator_widget.dart';
part 'src/widgets/vertical_line.dart';
part 'src/widgets/voice_message_view.dart';
part 'src/widgets/reusables/gesture_detector_view.dart';
part 'src/widgets/reusables/message_time_widget.dart';
