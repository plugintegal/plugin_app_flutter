import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/main_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/pages/profile_page.dart';
import 'package:plugin_app_flutter/presenters/main_presenter.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plugin_app_flutter/pages/login_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements MainView{
  MainPresenter _presenter;
  int _selectedBottomNavIndex = 0;
  Widget _w;

  Future<bool> _isNotLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('api_token') ?? "undefined");
    return (token == null || token == "undefined");
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  @override
  void initState() {
    super.initState();
    _isNotLoggedIn().then((it) {
      if(it){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));}
      return;
    });

    _presenter = MainPresenter(this);
    _w = FutureBuilder(
        future: _presenter?.fetchAllUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                return userAdapter(context, snapshot);
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:16.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFloatingBar(
                floating: true,
                title: TextField(
                  decoration: InputDecoration.collapsed(hintText: "Search"),
                ),
                trailing: GestureDetector(
                  child: CircleAvatar(
                    child: Text("P"),
                  ),
                  onTap: (){
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: Text("Opsi"),
                          cancelButton: CupertinoActionSheetAction(
                            child: Text("Batal"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("Profil"),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Sign out"),
                              onPressed: (){
                                _logout();
                                Navigator.pop(context);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                            ),
                          ],
                        )
                    );
                  },
                )
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                child: _w,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text("Dashboard")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text("Events")
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (i){
          setState(() {
            _selectedBottomNavIndex = i;
            if(i == 0){
              _w = FutureBuilder(
                  future: _presenter?.fetchAllUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return userAdapter(context, snapshot);
                        }
                    }
                  });
            }else{
              _w = Text("Garo");
            }
          });
        },
      ),
    );
  }

  Widget userAdapter(BuildContext context, AsyncSnapshot snapshot){
    List<User> users = snapshot.data;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(users.length, (index){
          return GestureDetector(
              onTap: (){
                this.toast(users[index].memberId);
              },
              child: Container(
                margin: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.only(left:8.0, right: 8.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              child: Text("P"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    users[index].name ?? "",
                                    style: Theme.of(context).textTheme.display1.copyWith(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    users[index].email ?? "",
                                    maxLines: 3,
                                    style: Theme.of(context).textTheme.body1.copyWith(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.hdr_strong),
                                onPressed: () => this.toast("haha"),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )
                ),
              )
          );
        })
    );
  }

  @override
  void toast(String message) => Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

  @override
  void dispose() {
    super.dispose();
    _presenter.detach();
  }
}
