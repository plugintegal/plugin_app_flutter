import 'package:dio/dio.dart';

class RestClient {
  static const BASE_URL = "https://plugin-apps-server.herokuapp.com/";
  static Dio _dio;
  static Dio instance(){
    if(_dio == null){
      BaseOptions opt = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        sendTimeout: 30000
      );
      _dio = Dio(opt);
      return _dio;
    }
    return _dio;
  }

  static const login = BASE_URL+"api/login";
  static const all_user = BASE_URL+"api/users";

}