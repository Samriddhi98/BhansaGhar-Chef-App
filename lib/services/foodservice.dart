import 'dart:io';


import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FoodService{
   String baseUrl = "https://bhansagharapi.herokuapp.com";
  Dio dio = Dio();


  


  
  Future<Response> postAddFood(Map<String,dynamic> formData, String token) async {
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
  }
}
