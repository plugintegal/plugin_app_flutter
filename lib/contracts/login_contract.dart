abstract class LoginView{
  void isLoading(bool state);
  void toast(String message);
  void success();
}

abstract class LoginInteractor{
  void login(String memberId, String password);
  void detach();
}