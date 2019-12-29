import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EventMenu extends StatefulWidget {
  @override
  _EventMenuState createState() => _EventMenuState();
}

class _EventMenuState extends State<EventMenu>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello world!"),
      ),
    );
  }

  void toast(String message) => Toast.show(message, context);
}