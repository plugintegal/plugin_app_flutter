import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/contracts/login_contract.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_response.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/utils/utilities.dart';

class LoginPresenter implements LoginInteractor {
  LoginView _view;
  LoginPresenter(this._view);
  Dio _api = RestClient.instance();

  @override
  void detach() {_view = null;}

  @override
  void login(String memberId, String password) async {
    _view?.isLoading(true);
    await _api.post(RestClient.login,
        data: {"member_id": memberId, "password" : password}).then((it){
          WrappedResponse response = WrappedResponse.fromJson(it.data);
          if(response.status){
            print(response.results.toString());
            var data = User.fromJson(response.results);
            Utilities.setToken(data.apiToken);
            _view?.success();
          }else{
            _view?.toast("Tidak dapat masuk. Periksa member id dan password anda");
          }
        }).catchError((Object e){
          switch(e.runtimeType){
            case DioError:
              final res = (e as DioError).response;
              _view?.toast("Terjadi kesalahan dengan status code "+res.statusCode.toString());
          }
    });
    _view?.isLoading(false);
  }
}