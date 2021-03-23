import 'dart:convert';
import 'dart:io';

import 'package:BhansaGharChef/models/chefModel.dart';
import 'package:BhansaGharChef/models/loginModel.dart';
import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  String baseUrl = "https://bhansagharapi.herokuapp.com";
  Dio dio = Dio();

  Future<Chef> getChefDetails(String token) async {
    String endPoint = "/api/v1/auth/me";
    String url = baseUrl + endPoint;
    Response response;
    Map chefMap;
    var chef;
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print(response.data);
        // chefMap = jsonDecode(response.data);
        chef = Chef.fromJson(response.data["data"]);
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
    String endPoint = "/api/v1/auth/register";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<RegisterModel> registermodelData;
    Response response;
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.post(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
          data: {
            "name": "${rm.firstName} ${rm.lastName}",
            "username": "${rm.username}",
            "email": "${rm.email}",
            "password": "${rm.password}",
            "location": "${rm.location}",
            "contact": " ${rm.contact}",
            "account": " ${rm.account}"
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
}
