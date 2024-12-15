// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';

abstract class RoomManager {
  RoomManager() {
    init();
  }

  final ValueNotifier<List<ChatDataBaseService>> chatDataBasesNotifier =
      ValueNotifier([]);

  final StreamController<List<DatabaseManager>> chattersStream =
      StreamController<List<DatabaseManager>>();

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
