import 'package:plugin_app_flutter/models/user.dart';

abstract class PersonInteractor {
  void detach();
  Future<User> getPerson(String id);
}

abstract class PersonView {
  void toast(String message);
}