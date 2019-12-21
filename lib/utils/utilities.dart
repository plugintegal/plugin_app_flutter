import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  static setToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("api_token", "Bearer "+token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('api_token') ?? "undefined");
    return token;
  }
}
