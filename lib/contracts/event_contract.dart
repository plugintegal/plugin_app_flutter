import 'package:plugin_app_flutter/models/event.dart';

abstract class EventInteractor {
  Future<List<Event>> fetchAllEvent();
  void detach();
}

abstract class EventView {
  void toast(String message);
}