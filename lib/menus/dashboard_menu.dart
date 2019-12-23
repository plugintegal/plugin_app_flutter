import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/contracts/dashboard_contract.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:plugin_app_flutter/presenters/dashboard_presenter.dart';
import 'package:toast/toast.dart';

class DashboardMenu extends StatefulWidget {
  @override
  _DashboardMenuState createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> implements DashboardView {
  DashboardPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DashboardPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _presenter.fetchAllUser(),
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
      },
    );
  }

  @override
  void toast(String message) => Toast.show(message, context);

  Widget userAdapter(BuildContext context, AsyncSnapshot snapshot) {
    List<User> users = snapshot.data;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(users.length, (index) {
          return GestureDetector(
              onTap: () {
                this.toast(users[index].memberId);
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
                                onPressed: () => this.toast("haha"),
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
