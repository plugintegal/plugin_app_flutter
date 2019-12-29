import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/pages/person_page.dart';

class DashboardMenu extends StatefulWidget {
  @override
  _DashboardMenuState createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchAllUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.err.toString()),
            ));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, state) {
            if (state is UserInitState) {
              return _showLoading();
            } else if (state is UserLoadingState) {
              return _showLoading();
            } else if (state is UserLoadedState) {
              if (state.users.isEmpty) {
                return _showEmptyView();
              }
              return userBuild(state.users);
            } else if (state is UserErrorState) {
              return _showError(state.err);
            }else{
              return Text("hoho");
            }
          },
        ),
      ),
    );
  }

  Widget _showLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _showError(String err) {
    return Center(
      child: Text(err.toString()),
    );
  }

  Widget _showEmptyView() {
    return Center(
      child: Text("Empty view"),
    );
  }

  Widget userBuild(List<User> users) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(users.length, (index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PersonPage(person: users[index])));
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
                child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  "https://ih1.redbubble.net/image.526556262.0001/flat,1000x1000,075,f.u1.jpg"),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                          fontSize: 16.0,
                                        ),
                                  ),
                                  Text(
                                    users[index].email ?? "",
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(
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
                                onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Something"),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ));
        }));
  }
}
