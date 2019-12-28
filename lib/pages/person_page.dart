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
  ScrollController _scrollController;
  bool _isCollapsed = false;
  String _title = "";

  @override
  void initState() {
    super.initState();
    _presenter = PersonPresenter(this);
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if (_scrollController.offset > 224 && !_scrollController.position.outOfRange) {
          if(!_isCollapsed){
            _title = this.widget.person.name;
            _isCollapsed = true;
            setState(() {});
          }
       }
       if (_scrollController.offset <= 224 && !_scrollController.position.outOfRange) {
         if(_isCollapsed){
            _title = "";
            _isCollapsed = false;
            setState(() {});
         }
       }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 280.0,
            floating: false,
            elevation: 2.0,
            backgroundColor: Colors.deepOrange,
            pinned: true,
            title: Text(_title),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 46.0,
                    backgroundImage: NetworkImage("https://ih1.redbubble.net/image.526556262.0001/flat,1000x1000,075,f.u1.jpg"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(this.widget.person.name, style: TextStyle(
                      fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  Container(
                    child: Text(this.widget.person.email, style: TextStyle(
                      fontSize: 16.0, color: Colors.white
                    ),
                  ),
                  )
                ]
              ),
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),


              Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            Card(
                child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("BIO", style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(this.widget.person.name),
                      )
                    ],
                  ),
                ),
              ),
            
            
            
            ]
            ),
          )
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