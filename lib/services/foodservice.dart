import 'dart:io';


import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:dio/dio.dart';

class FoodService{
   String baseUrl = "https://bhansagharapi.herokuapp.com";
  Dio dio = Dio();

  
  Future<Response> postAddFood(FoodModel am) async {
    String endPoint = "/api/v1/foods";
    String url = baseUrl + endPoint;
    List<dynamic> responseData;
    List<FoodModel> addfoodmodelData;
    // print(rm.username);
    Response response;
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.post(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
          data: {
            "name": "${am.name}",
            "description": "${am.description}",
            "time": " ${am.time}",
            "price": " ${am.price}",
            "category": " ${am.category}",
            "type": " ${am.type}",
            "photo": " ${am.photo}"
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
  }
}
