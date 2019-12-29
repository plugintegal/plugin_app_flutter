import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            brightness: Brightness.dark,
            accentColor: Colors.deepOrangeAccent
          ),
          home: MainPage()
        )
    );
  }
}
