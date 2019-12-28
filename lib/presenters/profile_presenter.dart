import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/contracts/profile_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePresenter implements ProfileInteractor{
  Dio _api = RestClient.instance();
  ProfileView _view;
  ProfilePresenter(this._view);

  @override
  void detach() { _view = null; }

  @override
  fetchProfile() async{
    User user;
    _api.options.headers["Authorization"] = await getToken();
    var token =  await getToken();
    _view?.toast(token);
    _view?.isLoading(true);
    await _api.get(RestClient.profile).then((it){
      WrappedResponse res = WrappedResponse.fromJson(it.data);
      if(res.status){
        user = User.fromJson(res.results);
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
    _view?.isLoading(false);
    _view?.attachUser(user);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('api_token') ?? "undefined");
    return token;
  }
}