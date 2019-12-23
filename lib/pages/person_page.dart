import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/person_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/presenters/person_presenter.dart';
import 'package:toast/toast.dart';

class PersonPage extends StatefulWidget {
  final User person;

  PersonPage({Key key, @required this.person}) : super(key: key);
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> implements PersonView{
  PersonPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = PersonPresenter(this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: <Widget>[
          Text(this.widget.person.name),
          Text(this.widget.person.memberId)
        ],
      ),
    );
  }

  @override
  void toast(String message) => Toast.show(message, context);

  @override
  void dispose() {
    super.dispose();
    _presenter?.detach();
  }
}