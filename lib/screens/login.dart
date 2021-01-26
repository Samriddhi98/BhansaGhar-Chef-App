import 'dart:convert';
import 'dart:io';

import 'package:BhansaGharChef/models/loginModel.dart';
import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:BhansaGharChef/services/authservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginModel loginModel;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _togglevisibility = true;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  saveTopref(String token) async {
    var preference = await SharedPreferences.getInstance();
    preference.setString("token" , token);
   // String a = preference.getString("token");
    // print(a);
  }

  Dio dio = new Dio();
  String baseUrl = "https://bhansagharapi.herokuapp.com";




  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100.0),
              width: 100.0,
              height: 50.0,
              //   color: Colors.amber,
              child: FittedBox(
                  child: Image.asset(
                'assets/images/logo.PNG',
                height: 50.0,
                width: 100.0,
              )),
            ),
            Text('Food that feels like home')
          ]),

          Container(
            padding: EdgeInsets.only(top: 50.0),
            width: deviceSize.width,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: username,
                        validator: (name) {
                          Pattern pattern =
                              r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(name))
                            return 'Invalid username';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(height: 15.0),
                  Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(password))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.vpn_key),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _togglevisibility = !_togglevisibility;
                            });
                          },
                          icon: _togglevisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _togglevisibility,
                    ),
                  )
                ],
              ),
            ),
          ),

          //   SizedBox(
          //  height: 5.0,
          // ),
          Container(
            padding: EdgeInsets.only(top: 15.0, right: 20.0),
            alignment: Alignment(1.0, 0.0),
            // color: Colors.blue,
            child: InkWell(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.yellow[700],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          GestureDetector(
                      child: Container(
              height: 40.0,
              width: 350.0,
            
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.black87,
                  color: Colors.black,
                  elevation: 7.0,
                  child: Center(
                      child: Text('LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              
              
            ),
            onTap: () {
                  print(username.text);
                  //
                  if (_formKey.currentState.validate()) {
                    loginModel = LoginModel(
                      username: username.text,
                      email: email.text,
                      password: password.text,
                    );
                    AuthService().postUserLogin(loginModel).then((value) {
                      if (value.statusCode == 200) {
                        saveTopref(value.data['token']);
                        
                      //  Navigator.pop(context);
                        Navigator.of(context).pushNamed('/main-screen');
                      } else if (value.statusCode == 400) {
                        print("eereafsdfasdfadsf");
                        print(value.data['error']);
                        Fluttertoast.showToast(
                          msg: value.data['error'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize:10.0,
                        );
                      } else {
                         Fluttertoast.showToast(
                        //  msg: value.data['error'],
                        
                          msg: 'Invalid username or password.Try Again',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize:10.0,
                        ); 
                      }
                    }
                    );
                  } else {
                    print("not validated");
                      Fluttertoast.showToast(
                          msg: 'Invalid username or password.Try Agia',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize:10.0,
                        );
                  }
                },
          ),
          SizedBox(height: 20.0),
          Container(
            height: 40.0,
            width: 350.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child:
                          ImageIcon(AssetImage('assets/images/facebook.png')),
                    ),
                    SizedBox(width: 10.0),
                    Center(
                      child: Text(
                        'Log in with facebook',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('New to BhansaGhar?'),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed('/sign-up');
                  Navigator.of(context).pushReplacementNamed('/sign-up');
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(
                      color: Colors.yellow[700],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
