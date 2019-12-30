import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/menus/profile_menu.dart';
import 'package:plugin_app_flutter/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: (){Navigator.pop(context, false);},
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                ),
                title: Text("Profil"),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.info_outline),),
                    Tab(icon: Icon(Icons.star),)
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  ProfileMenu(),
                  Text("Kontoru")
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditProfilePage()
                  )
                  );
                  },
                child: Icon(Icons.create),
              ),
            ),
          )
    );
  }
}