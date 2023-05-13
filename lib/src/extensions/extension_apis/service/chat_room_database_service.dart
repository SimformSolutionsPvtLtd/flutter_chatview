import 'dart:async';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';

abstract class ChatRoomDataBaseService {
  ChatRoomDataBaseService() {
    init();
  }

  final ValueNotifier<List<ChatDataBaseService>> chatDataBasesNotifier =
      ValueNotifier([]);

  final StreamController<List<DataBaseService>> chattersStream =
      StreamController<List<DataBaseService>>();

  void init();

  void dispose() {
    chattersStream.close();
  }

  Future<bool> createRoom(Room room);

  Future<bool> deleteRoom(Room room);

  Future<bool> deleteRooms(List<Room> rooms);

  Future<List<ChatDataBaseService>> fetchRooms([limit = 30]);

  ChatDataBaseService? getInstanceById(String id);

  addRoomsToList(List<ChatDataBaseService> cdbs) {
    chatDataBasesNotifier.value.addAll(cdbs);
    chatDataBasesNotifier.notifyListeners();
  }
}
