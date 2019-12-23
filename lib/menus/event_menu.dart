import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/event_contract.dart';
import 'package:plugin_app_flutter/presenters/event_presenter.dart';
import 'package:toast/toast.dart';

class EventMenu extends StatefulWidget {
  @override
  _EventMenuState createState() => _EventMenuState();
}

class _EventMenuState extends State<EventMenu> implements EventView{
  EventPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = EventPresenter(this);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello world!"),
      ),
    );
  }

  @override
  void toast(String message) => Toast.show(message, context);

  @override
  void dispose() {
    super.dispose();
  
  }
}