import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_bloc.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_event.dart';
import 'package:plugin_app_flutter/bloc/user_bloc/user_state.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        accentColor: Colors.deepOrangeAccent
      ),
      home: BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: LoginScreen()
      )
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _etMember = TextEditingController();
  TextEditingController _etPassword = TextEditingController();
  var _defaultLoadingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state){
          if(state is UserErrorState){
            _defaultLoadingValue = 0.0;
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.err.toString())));
          }else if (state is UserSingleLoadedState){
            _defaultLoadingValue = 0.0;
            _success();
          }else if(state is UserLoadingState){
            _defaultLoadingValue = null;
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state){
            return Container(
              padding: EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.white)),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Text("Masuk dengan id PLUGIN yang anda miliki. Jika anda tidak tahu atau belum memiliki id, hubungi pengurus PLUGIN segera"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: LinearProgressIndicator(
                      value: _defaultLoadingValue,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            controller: _etMember,
                            decoration: InputDecoration(
                              labelText: "ID Plugin",
                              prefixIcon: Icon(Icons.perm_identity)
                            ),
                              validator: (value){
                                if(!value.startsWith("PLGN")){
                                  return "ID Plugin tidak valid";
                                }
                                return null;
                              },
                              ),
                        ),
                        
                        TextFormField(
                          controller: _etPassword,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility),
                            prefixIcon: Icon(Icons.security),
                            labelText: "Password"
                            ),
                            validator: (value){
                              return value.length < 8? "Password tidak valid" : null;
                            },
                            obscureText: true,
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: RaisedButton(
                              
                              textColor: Colors.white,
                              color: Colors.deepOrange,
                              onPressed: (state is UserLoadingState) ? null :  () async {
                                if(state is UserLoadingState){
                                  return null;
                                }else{
                                  if(_formKey.currentState.validate()){
                                    _userBloc.add(DoLogin(
                                      member: _etMember.text.toString().trim(),
                                      password: _etPassword.text.toString().toString())
                                    );
                                  }
                                }
                              },
                              child: Text("Masuk"),
                            ),
                          ),
                        )
                        ],
                      )                      
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _success() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
}