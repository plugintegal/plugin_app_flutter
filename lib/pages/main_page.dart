import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plugin_app_flutter/pages/login_page.dart';
import 'package:plugin_app_flutter/menus/dashboard_menu.dart';
import 'package:plugin_app_flutter/menus/event_menu.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedBottomNavIndex = 0;
  PageStorageBucket bucket = PageStorageBucket();
  List<Widget> menus;

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
      if (it) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
      return;
    });
    menus = [DashboardMenu(), EventMenu()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFloatingBar(
                    floating: true,
                    leading: IconButton(
                      icon: Icon(Icons.dehaze),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                                  title: Text("Opsi"),
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text("Batal"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      child: Text("Pengaturan"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: Text("Sign out"),
                                      onPressed: () {
                                        _logout();
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                    ),
                                  ],
                                ));
                      },
                    ),
                    title: TextField(
                      decoration: InputDecoration.collapsed(hintText: "Search"),
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Text(
                          "P",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                    )),
                SliverToBoxAdapter(
                  child: Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: PageStorage(
                        child: menus[_selectedBottomNavIndex],
                        bucket: bucket,
                      )),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.group_work), title: Text("Members")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event_note), title: Text("Events")),
            ],
            currentIndex: _selectedBottomNavIndex,
            onTap: (i) {
              setState(() {
                _selectedBottomNavIndex = i;
              });
            },
          ),
        ));
  }
}
