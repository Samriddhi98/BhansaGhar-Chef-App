
import 'package:flutter/material.dart';


//screens
import 'package:BhansaGharChef/screens/login.dart';
import 'package:BhansaGharChef/screens/signup.dart';


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
          theme: ThemeData(
            primaryColor: Colors.yellow[700],
            // primarySwatch: Colors.purple,
            accentColor: Colors.redAccent,
            //fontFamily: 'Lato',
          ),
          home: LogIn(),
          routes: <String, WidgetBuilder>{
            '/sign-up': (BuildContext context) => new SignUp(),
            '/log-in' : (BuildContext context) => new LogIn(),
          },
    );
  }
}

