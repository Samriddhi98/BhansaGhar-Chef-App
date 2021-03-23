import 'dart:convert';
import 'dart:io';

import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodService {
  String token;

  Future<void> setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    this.token = prefs.getString("token");
    print('add food token$token');
  }

  String baseUrl = "https://bhansagharapi.herokuapp.com";
  Dio dio = Dio();

  /* Future<Response> postAddFood(Map<String,dynamic> formData, String token) async {
    String endPoint = "/api/v1/foods";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<FoodModel> addfoodmodelData;
    // print(rm.username);
    Response response;
    try {
     //  String fileName = am.photo.split('/').last;
      // dio.options.headers['Content-Type'] = 'application/json';
      FormData.fromMap({

      });
      response = await dio.post(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json', 
                        HttpHeaders.authorizationHeader:'Bearer $token',}),
          data: {
            "name": "${formData["name"]}",
            "description": "${formData["description"]}",
            "time": " ${formData["time"]}",
            "price": " ${formData["price"]}",
            "category": " ${formData["category"]}",
            "type": " ${formData["type"]}",
            "photo": "${formData["photo"]}"
          });

      if (response.statusCode == 200) {
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print(response.data);
        return response;
      }
    } catch (e) {
      print("Errrorr aaayo! k error aayo ta? ${e}");
      DioError err;
      err = e;
      print(err.response);
      return err.response;
    }

    return response;
  } */

  Future<List<FoodModel>> getFoodDetails(String id) async {
    await setTokenValuesSF();
    print(id);
    String endPoint = "/api/v1/foods/me/$id";
    String url = baseUrl + endPoint;
    print(token);
    List<dynamic> responseData;
    List<FoodModel> foodListData;
    // print(rm.username);
    Response response;
    try {
      //  String fileName = am.photo.split('/').last;
      // dio.options.headers['Content-Type'] = 'application/json';
      FormData.fromMap({});
      response = await dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 200) {
        responseData = response.data["data"];
        print(responseData.runtimeType);

        foodListData = responseData.map((e) => FoodModel.fromJson(e)).toList();
        // registermodelData =
        //     responseData.map((e) => RegisterModel.fromJson(e)).toList();
        print("food response");
        print(response.data);

        // List<FoodModel> foodlist = [];
        // Map foodMap = jsonDecode(response.data);
        // food = FoodModel.fromJson(foodMap);
        // foodlist.add(food);
        List<dynamic> foodlists = response.data["data"];

        List<FoodModel> foodlist =
            foodlists.map((e) => FoodModel.fromJson(e)).toList();

        return foodListData;
        // return response;
      }
    } catch (e) {
      print("Errrorr aaayo! k error aayo ta? $e");
      DioError err;
      err = e;
      print(err.response);
      // return err.response;
    }

    return foodListData;
  }
}
