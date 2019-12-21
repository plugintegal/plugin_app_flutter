import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/models/event.dart';

class MainInteractor {
  Future<List<User>> fetchAllUser(){}
  Future<List<Event>> fetchAllEvent(){}
  void detach(){}
}

class MainView {
  void toast(String message){}
}