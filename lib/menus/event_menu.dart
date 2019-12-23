import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/event_contract.dart';
import 'package:toast/toast.dart';

class EventMenu extends StatefulWidget {
  @override
  _EventMenuState createState() => _EventMenuState();
}

class _EventMenuState extends State<EventMenu> implements EventView{
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
}