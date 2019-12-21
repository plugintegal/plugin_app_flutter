import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
              Text("Info"),
              Text("Capaian")
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
}
