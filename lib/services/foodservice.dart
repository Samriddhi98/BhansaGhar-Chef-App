import 'dart:convert';
import 'dart:io';

import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:BhansaGharChef/models/orderModel.dart';
import 'package:BhansaGharChef/screens/addfood.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class FoodService {
  String token;
  String id;

  Future<void> setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    this.token = prefs.getString("token");
    //  print('add food token$token');
  }

  Future<void> setIdValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    id = prefs.getString("cid");
    // rint('chef $id');
  }

  // String baseUrl = "https://bhansagharapi.herokuapp.com";
  // String baseUrl = "http://10.0.2.2:5000";
  // String baseUrl = "http://192.168.2.229:5000";
  String baseUrl = "http://192.168.1.121:5000";

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

  Future<List<FoodModel>> getFoodDetails() async {
    await setIdValuesSF();
    await setTokenValuesSF();
    //  print('get food details: $id');
    String endPoint = "/api/v1/foods/me/$id";
    String url = baseUrl + endPoint;
    // print('get food details: $token');
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
        //  print("food response");
        //   print(response.data);

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

  Future<Response> deleteSingleFood(String id) async {
    await setTokenValuesSF();
    print('food id$id');
    String endPoint = "/api/v1/foods/$id";
    String url = baseUrl + endPoint;

    List<dynamic> responseData;
    List<FoodModel> foodListData;
    // print(rm.username);
    Response response;
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.delete(
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
        return response;
      }
    } catch (e) {
      print("Errrorr aaayo! k error aayo ta? $e");
      DioError err;
      err = e;
      print(err.response);
      // return err.response;
    }

    return response;
  }

  Future<Response> addFood(FoodModel foodModel) async {
    await setTokenValuesSF();
    String fileName = foodModel.photo.path
        .split('/')
        .last; //   String fileName = file.path.split('/').last;

    var headers = {
      'authorization': 'Bearer $token',
    };
    print('hello');
    var image = await MultipartFile.fromFile(foodModel.photo.path,
        filename: fileName, contentType: MediaType('image', 'jpeg'));

    var data = FormData.fromMap({
      "photo": image,
      "name": foodModel.name,
      "price": foodModel.price,
      "description": foodModel.description,
      "time": foodModel.time,
      "category": foodModel.category,
      "type": foodModel.type,
    });

    print(data.fields);
    print(data.files);
    Dio dio = new Dio();
    // String baseUrl = "https://bhansagharapi.herokuapp.com";
    String endPoint = "/api/v1/foods";
    String url = baseUrl + endPoint;
    final response = await dio.post(url,
        data: data,
        options: Options(headers: headers, contentType: "application/json"));
    return response;
    // print(response.statusCode);

    //dio.options.contentType= Headers.formUrlEncodedContentType;
    /* dio.post(url,
  options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json',
                        HttpHeaders.authorizationHeader:'Bearer $token',}),
  data: data)
  .then((response) => print(response))
  .catchError((error) => print(error)); */
  }

  Future<Response> updateFood(
      FoodModel foodModel, String foodId, bool hasphoto) async {
    await setTokenValuesSF();
    MultipartFile image;
    Map data;
    print('edited orice${foodModel.price}');
    print('food id for edit$foodId');
    print('has photo value$hasphoto');
    if (hasphoto == true) {
      String fileName = foodModel.photo.path.split('/').last;

      image = await MultipartFile.fromFile(foodModel.photo.path,
          filename: fileName, contentType: MediaType('image', 'jpeg'));

      data = {
        "photo": image,
        "name": foodModel.name,
        "price": foodModel.price,
        "description": foodModel.description,
        "time": foodModel.time,
        "category": foodModel.category,
        "type": foodModel.type,
      };
    } else {
      // data = FormData.fromMap({
      //   // "photo": image,
      //   "name": foodModel.name,
      //   "price": foodModel.price,
      //   "description": foodModel.description,
      //   "time": foodModel.time,
      //   "category": foodModel.category,
      //   "type": foodModel.type,
      // });

      data = {
        // "photo": image,
        "name": foodModel.name,
        "price": foodModel.price,
        "description": foodModel.description,
        "time": foodModel.time,
        "category": foodModel.category,
        "type": foodModel.type,
      };
    }

    var headers = {
      'authorization': 'Bearer $token',
    };

    // print(data.fields);
    // print(data.files);
    Dio dio = new Dio();
    // String baseUrl = "https://bhansagharapi.herokuapp.com";
    String endPoint = "/api/v1/foods/$foodId";
    String url = baseUrl + endPoint;
    final response = await dio.put(url,
        data: data,
        options: Options(headers: headers, contentType: "application/json"));
    print('edit food ko response$response');
    return response;
  }

  Future<List<OrderModel>> getOrderDetails() async {
    await setIdValuesSF();
    await setTokenValuesSF();
    //  print('get food details: $id');
    String endPoint = "/api/v1/orders/$id";
    String url = baseUrl + endPoint;
    // print('get food details: $token');
    List<dynamic> responseData;
    List<OrderModel> orderListData;
    // print(rm.username);
    Response response;
    try {
      response = await dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Authorization": "Bearer $token"
        }),
      );

      if (response.statusCode == 201) {
        responseData = response.data["data"];
        print(responseData);
        print('order data:${responseData.runtimeType}');

        orderListData = // responseData.map((e) => print('hello'));
            responseData.map((e) => OrderModel.fromJson(e)).toList();

        return orderListData;
        // return response;
      }
    } catch (e) {
      print("Errrorr aaayo! k error aayo ta? $e");
      DioError err;
      err = e;
      print(err.response);
      // return err.response;
    }

    return orderListData;
  }
}
