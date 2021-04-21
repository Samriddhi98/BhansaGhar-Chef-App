import 'dart:io';

import 'package:BhansaGharChef/models/chefModel.dart';
import 'package:BhansaGharChef/models/loginModel.dart';
import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String token;
  String fcmToken;

  Future<void> setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    this.token = prefs.getString("token");
    print('chef ko token $token');
  }

  Future<void> setfcmTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    this.fcmToken = prefs.getString("fcmtoken");
    print('chef ko token $fcmToken');
  }

  // String baseUrl = "https://bhansagharapi.herokuapp.com";
  //String baseUrl = "http://10.0.2.2:5000";
  // String baseUrl = "http://192.168.2.229:5000";
  String baseUrl = "http://192.168.1.121:5000";
  Dio dio = Dio();

  Future<Chef> getChefDetails(String token) async {
    setTokenValuesSF();
    String endPoint = "/api/v1/auth/me";
    String url = baseUrl + endPoint;
    Response response;
    Map chefMap;
    var chef;
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      //  print(token);
      response = await dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        print(response.data);

        Chef chef = Chef.fromJson(response.data["data"]);
        print('chef id in getChefdetail${chef.id}');

        return chef;
      }
    } catch (e) {
      print("Error $e");
      DioError err;
      err = e;
      print(err.response);
      // return err.response;
    }

    return chef;
  }

  Future<Response> postUser(RegisterModel rm) async {
    await setfcmTokenValuesSF();
    print('fcmtoken$fcmToken');
    String endPoint = "/api/v1/auth/register";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<RegisterModel> registermodelData;
    Response response;
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.post(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }),
          data: {
            "name": "${rm.firstName} ${rm.lastName}",
            "username": "${rm.username}",
            "email": "${rm.email}",
            "password": "${rm.password}",
            "location": "${rm.location}",
            "contact": " ${rm.contact}",
            "account": " ${rm.account}",
            "fcmToken": fcmToken
          });

      if (response.statusCode == 200) {
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print(response.data);
        return response;
      }
    } catch (e) {
      print("Error ${e}");
      DioError err;
      err = e;
      print(err.response);
      return err.response;
    }

    return response;
  }

  Future<Response> postUserLogin(LoginModel lm) async {
    String endPoint = "/api/v1/auth/login";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<RegisterModel> registermodelData;
    Response response;
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.post(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
          data: {
            "username": "${lm.username}",
            // "email": "${lm.email}",
            "password": "${lm.password}",
          });

      if (response.statusCode == 200) {
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print(response.data);
        return response;
      }
    } catch (e) {
      print("Error ${e}");
      DioError err;
      err = e;
      print(err.response);
      return err.response;
    }
  }

  Future<Response> updatePassword({String oldpass, String newpass}) async {
    await setTokenValuesSF();
    print('token in update password:$token');
    String endPoint = "/api/v1/auth/updatepassword";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<RegisterModel> registermodelData;
    Response response;
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.put(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Authorization": "Bearer $token"
          }),
          data: {
            "currentPassword": "${oldpass}",
            "newPassword": "${newpass}",
          });

      if (response.statusCode == 200) {
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print(response.data);
        return response;
      } else {
        Fluttertoast.showToast(
          msg: 'SignUp failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      print("Error ${e}");
      DioError err;
      err = e;
      print(err.response);
      Fluttertoast.showToast(
        msg: 'SignUp failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      // return toast(err.response);
    }
  }
}
