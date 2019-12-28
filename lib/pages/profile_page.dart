import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/profile_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/presenters/profile_presenter.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements ProfileView{
  bool _isLoading = false;
  User _user;
  ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter(this);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        accentColor: Colors.deepOrangeAccent
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,),
            ),
            title: Text("Profil"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.info_outline),
                ),
                Tab(
                  icon: Icon(Icons.star),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder(
                future: _presenter?.fetchProfile(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        toast(snapshot.error.toString());
                        return Text("Error");
                      } else {
                        return attachProfileMenu(context);
                      }
                  }
                },
                ),
              Text("KOntoru"),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              print("FAB edit");
              },
            child: Icon(Icons.create),
          ),
        ),
      ),
    );
  }


  Widget attachAchievementMenu() {
    if(_user == null || _isLoading){
      toast("User is  "+ (_user == null).toString());
      toast("isLoading "+ (_isLoading).toString());

      return Container(
        child: Text("Hehe"),
      );
    }else{
      return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Achievement"),
          Text("Achievement")
        ],
      ),
    );
    }
  }

  Widget attachProfileMenu(BuildContext context) {
    print("Awake user is null" + (_user == null).toString());
    toast("User is  "+ (_user == null).toString());
    toast("isLoading "+ (_isLoading).toString());

    if(_user == null || _isLoading){
      toast("Tidak dapat mengambil data profile");
      return Container(
        child: Text("Hehe"),
      );
    }else{
      return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Prieyudha Akadita S"),
          Text("Prieyudha Akadita S")
        ],
      ),
    );
    }
  }

  @override
  void isLoading(bool state) {
    setState(() {
      if(state){
        _isLoading = true;
      }else{
        _isLoading = false;
      }
    });
  }

  @override
  void toast(String message) => Toast.show(message, context);

  @override
  attachUser(User user) {
    setState(() {
      print("Miri krisimis" + _user.name.toString());

      _user = user;
    });
  }
}
