import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/utils/utilities.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_list_response.dart';
import 'package:plugin_app_flutter/webservices/wrapped_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Dio _api = RestClient.instance();

  @override
  UserState get initialState => UserInitState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchAllUserEvent) {
      yield* _fetchAllUser();
    } else if (event is FetchMyProfile) {
      yield* _currentUser();
    } else if (event is DoLogin){
      yield* _login(event.member, event.password);
    }
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('api_token') ?? "undefined");
    return token;
  }

  Stream<UserState>_fetchAllUser() async* {
    yield UserLoadingState();
    try {
      _api.options.headers["Authorization"] = await getToken();

      Response res = await _api.get(RestClient.all_user);
      WrappedListResponse wrappedListResponse =
          WrappedListResponse.fromJson(res.data);
      if (wrappedListResponse.status) {
        var res = wrappedListResponse.results;
        List<User> users = List();
        for (var user in res) {
          users.add(User.fromJson(user));
        }
        yield UserLoadedState(users: users);
      } else {
        yield UserErrorState(err: "Tidak dapat mengambil data dari server");
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          yield UserErrorState(
              err: "Terjadi kesalahan dengan status code " +
                  res.statusCode.toString());
          break;
        default:
          yield UserErrorState(err: "Terjadi kesalahan " + e.toString());
      }
    }
  }

  Stream<UserState>_currentUser() async* {
    try {
      _api.options.headers["Authorization"] = await getToken();
      Response res = await _api.get(RestClient.profile);
      
      print(res.data);
      WrappedResponse wr = WrappedResponse.fromJson(res.data);
      if (wr.status) {
        User user = User.fromJson(wr.results);
        yield UserSingleLoadedState(user: user);
      } else {
        yield UserErrorState(err: "Tidak dapat mengambil data dari server");
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          yield UserErrorState(
              err: "Terjadi kesalahan dengan status code ${res.statusCode.toString()}");
          break;
        default:
          yield UserErrorState(err: "Terjadi kesalahan ${e.toString()}");
      }
    }
  }

  Stream<UserState> _login(String memberId, String password) async*{
    try{
      yield UserLoadingState();
      Response res = await _api.post(RestClient.login, data: {
        "member_id":memberId, "password": password
      });
      WrappedResponse wrappedResponse = WrappedResponse.fromJson(res.data);
      if(wrappedResponse.status){
        var user = User.fromJson(wrappedResponse.results);
        Utilities.setToken(user.apiToken);
        yield UserSingleLoadedState(user: user);
      }else{
        yield UserErrorState(err: "Login gagal");
      }
    }catch(e){
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          print("Error with status code ${res.statusCode} : ${res.statusMessage}");
          yield UserErrorState(err: "Tidak dapat masuk.");
          break;
        default:
          yield UserErrorState(err: "Terjadi kesalahan ${e.toString()}");
      }
    }
  }
}
