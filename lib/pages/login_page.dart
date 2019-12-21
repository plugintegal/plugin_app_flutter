import 'package:flutter/material.dart';
import 'package:plugin_app_flutter/presenters/login_presenter.dart';
import 'main_page.dart';
import 'package:plugin_app_flutter/contracts/login_contract.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginView{
  var _formKey = GlobalKey<FormState>();
  double _defaultLinearProgress = 0.0;
  bool _isLoading = false;
  LoginPresenter _presenter;
  TextEditingController _etMember = TextEditingController();
  TextEditingController _etPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 64.0,
          left: 16.0,
          right: 16.0,
          bottom: 16.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Login",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text("Masuk dengan id PLUGIN yang anda miliki. Jika anda "
                  "tidak tahu atau belum memiliki id, hubungi pengurus PLUGIN segera"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: LinearProgressIndicator(
                value: _defaultLinearProgress,
              ),
            ),

            Form(
              key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: TextFormField(
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
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              if(!_isLoading){
                                _presenter.login(_etMember.text.trim(), _etPassword.text.trim());
                              }else{
                                return null;
                              }
                            }
                          },
                          child: Text("Masuk"),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  void isLoading(bool state) {
    setState(() {
      if(state){
        _isLoading = true;
        _defaultLinearProgress = null;
      }else{
        _isLoading = false;
        _defaultLinearProgress = 0.0;
      }
    });
  }

  @override
  void success() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));

  @override
  void toast(String message) => Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

  @override
  void dispose() {
    super.dispose();
    _presenter?.detach();
  }
}
