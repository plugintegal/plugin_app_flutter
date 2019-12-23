import 'package:dio/dio.dart';
import 'package:plugin_app_flutter/contracts/event_contract.dart';
import 'package:plugin_app_flutter/models/event.dart';
import 'package:plugin_app_flutter/webservices/RestClient.dart';

class EventPresenter implements EventInteractor{
  EventView _view;
  Dio _api = RestClient.instance();

  EventPresenter(this._view);
  
  @override
  void detach() { _view = null; }

  @override
  Future<List<Event>> fetchAllEvent() async{
    return List<Event>();
  }
  
}