import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RegisterModel {
  String firstName,
      lastName,
      username,
      email,
      password,
      location,
      contact,
      account;

  RegisterModel(
      {@required this.firstName,
      @required this.lastName,
      @required this.username,
      @required this.email,
      @required this.password,
      @required this.location,
      @required this.contact,
      @required this.account}
      );
      
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
    );
  }
}