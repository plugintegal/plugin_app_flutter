import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/main_contract.dart';
import 'package:plugin_app_flutter/pages/profile_page.dart';
import 'package:plugin_app_flutter/presenters/main_presenter.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plugin_app_flutter/pages/login_page.dart';
import 'package:plugin_app_flutter/menus/dashboard_menu.dart';
import 'package:plugin_app_flutter/menus/event_menu.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements MainView{
  MainPresenter _presenter;
  int _selectedBottomNavIndex = 0;

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
                                Navigator.pop(context);
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
                child: Stack(
                  children: <Widget>[
                    Offstage(
                      offstage: _selectedBottomNavIndex != 0,
                      child: TickerMode(
                        enabled: _selectedBottomNavIndex == 0,
                        child: DashboardMenu(),
                      ),
                    ),
                    Offstage(
                      offstage: _selectedBottomNavIndex != 1,
                      child: TickerMode(
                        enabled: _selectedBottomNavIndex == 1,
                        child: EventMenu(),
                      ),
                    )
                  ],
                )
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
          });
        },
      ),
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
