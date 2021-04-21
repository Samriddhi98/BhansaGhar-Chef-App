import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RegisterModel {
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String location;
  String contact;
  String account;
  String fcmToken;

  RegisterModel(
      {@required this.firstName,
      @required this.lastName,
      @required this.username,
      @required this.email,
      @required this.password,
      @required this.location,
      @required this.contact,
      @required this.account,
      @required this.fcmToken});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        location: json["location"],
        contact: json["contact"],
        account: json["account"],
        fcmToken: json["fcmToken"]);
  }
}
