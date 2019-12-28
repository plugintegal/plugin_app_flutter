import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_list_response.dart';

abstract class UserRepositories {
  Future<List<User>> fetchAllUsers();
}

class UserInteractor implements UserRepositories{
  Dio _api = RestClient.instance();

  @override
  Future<List<User>> fetchAllUsers() async{
    List<User> users = List();
    await _api.get(RestClient.all_user).then((it){
      WrappedListResponse response = WrappedListResponse.fromJson(it.data);
      if(response.status){
        var res = response.results;
        for(var user in res){
          users.add(User.fromJson(user));
        }
      }else{
      }
    }).catchError((Object e){
      switch(e.runtimeType){
        case DioError:
          final res = (e as DioError).response;
      }
    });
    return users;
  }

}