import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchMyProfile());
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UserLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UserSingleLoadedState) {
        if (state.user != null) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(bottom: 26, left: 16, right: 16, top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 26.0,
                        backgroundImage: NetworkImage(
                            "https://ih1.redbubble.net/image.526556262.0001/flat,1000x1000,075,f.u1.jpg"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.user.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.user.email,
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                          Text(
                            state.user.memberId,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.deepOrangeAccent),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          print("object");
                        },
                        child: Text(
                          "LIHAT GITHUB",
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: VerticalDivider(
                          width: 16,
                          color: Colors.white,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          print("object");
                        },
                        child: Text(
                          "TELEGRAM",
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "BIO",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: Text(
                              "Lorem ipsum dolor sit amet consectuer. Lorem ipsum dolor sit amet consectuer."))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "PERSONAL INFO",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: Text("TEGAL, 07-04-1998"))
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "TELEPON",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text("0822-2759-6264"),
                        ),
                        IconButton(
                          onPressed: () {
                            print("copy");
                          },
                          icon: Icon(Icons.content_copy),
                        )
                      ],
                    )
                  ],
                )
              )

              ],
            ),
          );
        }
        return Center(
          child: Text("Tidak ada sesi"),
        );
      } else if (state is UserErrorState) {
        return Center(
          child: Text("Error view"),
        );
      }
    });
  }
}
