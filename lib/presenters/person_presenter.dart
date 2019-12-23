import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/contracts/person_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_response.dart';

class PersonPresenter implements PersonInteractor{
  PersonView _view;
  Dio _api = RestClient.instance();

  PersonPresenter(this._view);
  
  @override
  void detach() { _view = null;  }

  @override
  Future<User> getPerson(String id) async{
    User user;
    var path = RestClient.get_user + id;
    await _api.get(path).then((it){
      WrappedResponse resp = WrappedResponse.fromJson(it.data);
      if(resp.status){
        user = User.fromJson(resp.results);
      }else{
        _view?.toast("Tidak dapat mengambil data dari server");
      }
    }).catchError((Object e){
      switch(e.runtimeType){
        case DioError:
          final res = (e as DioError).response;
          _view?.toast("Terjadi kesalahan dengan status code "+res.statusCode.toString());
      }
    });
    return user;
  }
}