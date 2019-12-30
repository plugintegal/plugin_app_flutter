import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserBloc _userBloc = UserBloc();
  var _formKey = GlobalKey<FormState>();
  var _etFullName = TextEditingController();
  var _etEmail = TextEditingController();
  var _etNickname = TextEditingController();
  var _etBio = TextEditingController();
  var _etTelegram = TextEditingController();
  var _etGithub = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userBloc.add(FetchMyProfile());
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profil"),
      ),
      body: BlocListener<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.err.toString())));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          bloc: _userBloc,
          builder: (_, state) {
            if (state is UserInitState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserSingleLoadedState) {
              _etFullName.text = state.user.name;
              _etEmail.text = state.user.email;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage(
                                  "https://ih1.redbubble.net/image.526556262.0001/flat,1000x1000,075,f.u1.jpg"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60, left: 66),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrangeAccent,
                                child:
                                    Icon(Icons.camera_alt, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 26),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _etFullName,
                              decoration: InputDecoration(
                                  labelText: "Nama lengkap",
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            TextFormField(
                              controller: _etEmail,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email)),
                            ),

                            TextFormField(
                              controller: _etBio,
                              decoration: InputDecoration(
                                  labelText: "Bio",
                                  prefixIcon: Icon(Icons.info_outline)),
                            ),

                            TextFormField(
                              controller: _etNickname,
                              decoration: InputDecoration(
                                labelText: "Nickname",
                                prefixIcon: Icon(Icons.alternate_email)
                              ),
                            ),
                            
                            TextFormField(
                              controller: _etTelegram,
                              decoration: InputDecoration(
                                labelText: "Telegram",
                                prefixIcon: Icon(Icons.send)
                              ),
                            ),

                            TextFormField(
                              controller: _etGithub,
                              decoration: InputDecoration(
                                labelText: "Github",
                                hintText: "contoh: https://github.com/@ydhnwb",
                                prefixIcon: Icon(Icons.category)
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: SizedBox(
                                width: double.infinity,
                                height: 46.0,
                                child: MaterialButton(
                                  onPressed: (){
                                    print("Tapp");
                                  },
                                  color: Colors.deepOrangeAccent,
                                  child: Text("SUBMIT"),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
