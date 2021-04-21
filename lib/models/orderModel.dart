// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:BhansaGharChef/models/foodModel.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.orderStatus,
    this.id,
    this.food,
    this.location,
    this.chefId,
    this.userId,
    this.createdAt,
    this.v,
    this.orderModelId,
  });

  String orderStatus;
  String id;
  List<FoodModel> food;
  String location;
  String chefId;
  String userId;
  DateTime createdAt;
  int v;
  String orderModelId;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderStatus: json["orderStatus"],
        id: json["_id"],
        // food: List<FoodModel>.from(
        //     json["food"].map((x) => FoodModel.fromJson(x))),
        location: json["location"],
        chefId: json["chefId"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        orderModelId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "orderStatus": orderStatus,
        "_id": id,
        //  "food": List<dynamic>.from(food.map((x) => x.toJson())),
        "location": location,
        "chefId": chefId,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": orderModelId,
      };
}

class Food {
  Food({
    this.quantity,
    this.id,
    this.foodid,
  });

  int quantity;
  String id;
  String foodid;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        quantity: json["quantity"],
        id: json["_id"],
        foodid: json["foodid"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "_id": id,
        "foodid": foodid,
      };
}
