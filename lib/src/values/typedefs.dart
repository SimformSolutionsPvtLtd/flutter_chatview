import 'package:flutter/material.dart';

import '../models/models.dart';

typedef StringCallback = void Function(String);
typedef StringMessageCallBack = void Function(
    String message, ReplyMessage replyMessage);
typedef ReplyMessageWithReturnWidget = Widget Function(
    ReplyMessage? replyMessage);
typedef ReplyMessageCallBack = void Function(ReplyMessage replyMessage);
typedef VoidCallBack = void Function();
typedef DoubleCallBack = void Function(double, double);
typedef MessageCallBack = void Function(Message message);
typedef VoidCallBackWithFuture = Future<void> Function();
typedef StringsCallBack = void Function(String emoji, String messageId);
typedef StringWithReturnWidget = Widget Function(String separator);
