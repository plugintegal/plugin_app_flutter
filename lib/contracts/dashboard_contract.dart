import 'package:plugin_app_flutter/models/user.dart';

abstract class DashboardInteractor {
  Future<List<User>> fetchAllUser();
  void detach();
}

abstract class DashboardView {
  void toast(String message);
}