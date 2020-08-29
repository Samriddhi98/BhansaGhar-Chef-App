
import 'package:BhansaGharChef/screens/addfood.dart';
import 'package:BhansaGharChef/screens/mainscreen.dart';
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
      title: 'BhansaGhar Chef',
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
            '/main-screen': (BuildContext context) => new MainScreen(),
            '/add-food': (BuildContext context) => new AddFood(),

          },
    );
  }
}

