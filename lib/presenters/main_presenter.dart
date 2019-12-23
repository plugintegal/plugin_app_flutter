import 'package:plugin_app_flutter/contracts/main_contract.dart';

class MainPresenter implements MainInteractor{
  MainView _view;
  MainPresenter(this._view);

  @override
  void detach() { _view = null; }
}