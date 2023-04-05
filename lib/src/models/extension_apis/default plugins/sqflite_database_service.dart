import 'package:chatview/src/models/extension_apis/service/chat_room_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/chat_database_service.dart';
import 'package:chatview/src/models/extension_apis/service/database_service.dart';
import 'package:chatview/src/models/extension_apis/service/user_profile_service.dart';
import 'package:chatview/src/utils/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../chat_user.dart';

class SqfliteDataBaseService extends DataBaseService {
  SqfliteDataBaseService(
      {
      required ChatDataBaseService chatDataBaseService,
      required ChatRoomDataBaseService chatRoomDataBaseService,
      required UserProfileService userProfileService,
      required ChatUser currentUser,
      })
      : super(
            chatDataBaseService: chatDataBaseService,
            currentUser: currentUser,
            chatRoomDataBaseService: chatRoomDataBaseService,
            userProfileService: userProfileService) {
    init();
  }

  late Database database;
  
  final tableName = 'xchatters';

  @override
  void init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demoDataBase.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "create table chatUsers( id text primary key, profilePhoto text, name text, map text );");
      await db.execute(
          "create table $tableName( id text primary key, remoteUsers text, isGroup int, map text );");
    });
    serviceLocator.registerSingleton<SqfliteDataBaseService>(this);
    super.init();
  }
}
