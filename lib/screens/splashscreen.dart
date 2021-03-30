import 'dart:async';

import 'package:BhansaGharChef/screens/login.dart';
import 'package:BhansaGharChef/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token;

  setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    token = prefs.getString("token");
    // print('add food token$token');
  }

  @override
  void initState() {
    super.initState();
    setTokenValuesSF();
    Timer(
        Duration(seconds: 3),
        () => token == null
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => LogIn()))
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height / 2,
              child: FittedBox(
                child: Image.asset(
                  'assets/images/landing.PNG',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height / 2,
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.PNG',
                    height: 49,
                    width: 106,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Food that feels like home'),
                ],
              ),
              // color: Colors.green,
            ),
          ),
          Container(
            width: deviceSize.width,
            height: 50.0,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(10.0),
            // color: Colors.blue,
            child: Text(
              'CHEF APP',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
