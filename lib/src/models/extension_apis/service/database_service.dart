import 'package:chatview/src/models/extension_apis/default%20plugins/sqflite_chatroom_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_room_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/user_profile_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:flutter/foundation.dart';

import '../../../../chatview.dart';

abstract class DataBaseService {
  DataBaseService(
      {required this.chatDataBaseService,
      required this.chatRoomDataBaseService,
      required this.userProfileService,
      required this.currentUser}) {
    init();
  }

  final ChatRoomDataBaseService chatRoomDataBaseService;
  final ChatDataBaseService chatDataBaseService;
  final UserProfileService userProfileService;
  final ChatUser currentUser;

  @mustCallSuper
  @protected
  void init() {
    serviceLocator.registerSingleton<UserProfileService>(userProfileService);
    serviceLocator
        .registerSingleton<ChatRoomDataBaseService>(chatRoomDataBaseService);
  }
}
