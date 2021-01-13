import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LoginModel {
  String 
      email,
      username,
      password;

     

  LoginModel(
      {
      @required this.username,
      @required this.email,
      @required this.password,
    });
      
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
    
      username: json["username"],
      email: json["email"],
      password: json["password"],
     
    );
  }
}