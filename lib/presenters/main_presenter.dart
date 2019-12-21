import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/contracts/main_contract.dart';
import 'package:plugin_app_flutter/models/event.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/utils/utilities.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_list_response.dart';

class MainPresenter implements MainInteractor{
  MainView _view;
  Dio _api = RestClient.instance();
  MainPresenter(this._view);

  @override
  void detach() { _view = null; }

  @override
  Future<List<Event>> fetchAllEvent() async{
    print("Fetch event");
    List<Event> l = List();
    return l;
  }

  @override
  Future<List<User>> fetchAllUser() async{
    List<User> users = List();
    await _api.get(RestClient.all_user).then((it){
      WrappedListResponse response = WrappedListResponse.fromJson(it.data);
      if(response.status){
        var res = response.results;
        for(var user in res){
          users.add(User.fromJson(user));
        }
      }else{
        _view?.toast("Tidak dapat mengambil data");
      }
    }).catchError((Object e){
      switch(e.runtimeType){
        case DioError:
          final res = (e as DioError).response;
          _view?.toast("Terjadi kesalahan dengan status code "+res.statusCode.toString());
      }
    });
    return users;
  }
}