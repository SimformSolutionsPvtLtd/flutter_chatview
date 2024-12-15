class PluginQueries {
  static const String getAllRoomsByLimit =
      'SELECT Rooms.* FROM rooms INNER join RoomUsers on RoomUsers.roomId = Rooms.id and RoomUsers.userId = "{} LIMIT {} OFFSET {}";';
  static const String getAllMessagesByLimit =
      'SELECT * from Messages WHERE roomid = "{}"  ORDER by createdAt DESC   LIMIT {}  OFFSET {};';
  static const String createMessagesTable = '''
        CREATE TABLE Messages
    (
    "id"             text NOT NULL,
    metadata       text NULL,
    createdAt      int NOT NULL,
    remoteId       text NULL,
    repliedMessage text NULL,
    showStatus     int NULL DEFAULT 1,
    status         text NOT NULL DEFAULT pending,
    type           text NOT NULL,
    updatedAt      int NULL,
    reaction       text NULL,
    text           text NULL,
    height         int NULL,
    width          int NULL,
    name           text NULL,
    size int NULL,
    "uri"            text NULL,
    mimeType       text NULL,
    duration       int NULL,
    customType     text NULL,
    roomId         text NULL,
    authorId       text NULL,
    CONSTRAINT PK_1 PRIMARY KEY ( "id" ),
    CONSTRAINT FK_4 FOREIGN KEY ( authorId ) REFERENCES ChatUser ( "id" ),
    CONSTRAINT FK_2 FOREIGN KEY ( roomId ) REFERENCES Rooms ( "id" )
    );

    CREATE INDEX authorId_index ON Messages
    (
    authorId
    );

    CREATE INDEX roomId_index ON Messages
    (
    roomId
    );
  ''';
  static const String createChatUser = '''
    CREATE TABLE ChatUser
    (
    "id"        text NOT NULL,
    lastName  text NULL,
    firstName text NULL,
    createdAt integer NULL,
    imageUrl  text NULL,
    lastSeen  integer NULL,
    metadata  text NULL,
    role      text NULL,
    updatedAt int NULL,
    CONSTRAINT PK_1 PRIMARY KEY ( "id" )
    );
 ''';
  static const String createRooms = '''
    CREATE TABLE Rooms
    (
    "id"            text NOT NULL,
    description   text NULL,
    name          text NULL,
    createdAt     int NOT NULL DEFAULT 0,
    imageUrl      text NULL,
    metadata      text NULL,
    type          text NULL,
    updatedAt     int NULL,
    lastMessageId text NULL,
    CONSTRAINT PK_1 PRIMARY KEY ( "id" ),
    CONSTRAINT FK_5 FOREIGN KEY ( lastMessageId ) REFERENCES Messages ( "id" )
    );
    CREATE INDEX lastMessageId_index ON Rooms
    (
    lastMessageId
    );
 ''';

  static const String createRoomUser = ''' 
  CREATE TABLE RoomUsers
  (
  userId text NOT NULL,
  roomId text NOT NULL,
  CONSTRAINT FK_4_1 FOREIGN KEY ( roomId ) REFERENCES Rooms ( "id" ),
  CONSTRAINT FK_2_1 FOREIGN KEY ( userId ) REFERENCES ChatUser ( "id" )
  );

  CREATE INDEX roomId_RoomUsers_index ON RoomUsers
  (
  roomId
  );

  CREATE INDEX userId_index ON RoomUsers
  (
  userId
  );
   ''';

  static const String getLastMessageByRoom =
      '''SELECT * from Messages WHERE roomid = '{}' ORDER by createdat DESC LIMIT 1''';

  static const String countOfMessagesByRoomId =
      '''  SELECT COUNT(*) FROM Messages where roomId = "{}" ''';

  static const String getMessagesByRoom =
      ''' SELECT Messages.*,ChatUser.id as UserId, ChatUser.firstName as user_firstName, ChatUser.lastName as user_lastName, ChatUser.createdAt as user_createdAt, ChatUser.imageUrl as user_imageUrl, ChatUser.lastSeen as user_lastSeen , ChatUser.metadata as user_metadata, ChatUser.role as user_role, ChatUser.updatedat as user_updatedAt from Messages INNER join ChatUser on Messages.authorid = ChatUser.id And Messages.roomid = '{}' ORDER by createdAt DESC LIMIT {} OFFSET {}; ''';

  static const String updateReaction =
      ''' UPDATE MESSAGES SET reaction = '{}' where id = "{}"  ''';

  static const String getRoomUsers =
      ''' SELECT userid,ChatUser.* from RoomUsers INNER join ChatUser on ChatUser.id = RoomUsers.userId and roomId = "{}" LIMIT {} OFFSET {}  ''';

  static String updateQuery(Map<String, dynamic> map) {
    String updateQuery = 'UPDATE Messages SET ';

    map.forEach((key, value) {
      if (key != 'id') {
        updateQuery += '$key = ';

        if (value is String) {
          updateQuery += "'$value', ";
        } else {
          updateQuery += '$value, ';
        }
      }
    });

    updateQuery = updateQuery.substring(
        0, updateQuery.length - 2); // Remove the trailing comma and space

    updateQuery += " WHERE id = '${map["id"]}';";
    return updateQuery;
  }
}
