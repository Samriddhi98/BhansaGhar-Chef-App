import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamed('/main-screen');
        },
        child: Scaffold(
          body: Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                            color: Colors.black38)
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60.0,
                    ),
                  ),
                  Container(
                    height: 102.0,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    // color:Colors.yellow,
                    alignment: Alignment.bottomRight,
                    child: FlatButton.icon(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          //Return String
                          Future<bool> token = prefs.setString("token", null);
                          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                        },
                        icon: Icon(Icons.exit_to_app),
                        label: Text('Log Out')),
                  ),
                ],
              )),
        ));
  }
}
