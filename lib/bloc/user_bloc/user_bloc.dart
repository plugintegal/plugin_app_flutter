import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';
import 'package:plugin_app_flutter/webservices/wrapped_list_response.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  Dio _api = RestClient.instance();

  @override
  UserState get initialState => UserInitState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    if(event is FetchAllUserEvent){
      yield UserLoadingState();
      try{
        Response res = await _api.get(RestClient.all_user);
        WrappedListResponse wrappedListResponse = WrappedListResponse.fromJson(res.data);
        if(wrappedListResponse.status){
          var res = wrappedListResponse.results;
          List<User> users = List();
          for(var user in res){ 
            users.add(User.fromJson(user));
          }
          yield UserLoadedState(users: users);
        }else{
          yield UserErrorState(err: "Tidak dapat mengambil data dari server");
        }
      }catch(e){
        switch(e.runtimeType){
          case DioError:
            final res = (e as DioError).response;
            yield UserErrorState(err: "Terjadi kesalahan dengan status code "+ res.statusCode.toString());
            break;
          default:
            yield UserErrorState(err: "Terjadi kesalahan "+e.toString());
        }
      }
    }
  }


}