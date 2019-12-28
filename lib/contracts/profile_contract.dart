import 'package:plugin_app_flutter/models/user.dart';

abstract class ProfileInteractor {
  fetchProfile();
  void detach();
}

abstract class ProfileView {
  void isLoading(bool state);
  void toast(String message);
  attachUser(User user);
}