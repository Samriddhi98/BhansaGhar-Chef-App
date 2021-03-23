import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';

/* List<FoodModel> usersFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String usersToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  File photo;
  String name,
      description,
      
      time,
      price,
      category;
      List<String> type=[];
  
 
  FoodModel(
      {
      @required this.name,
      @required this.description,
      @required this.type,
      @required this.time,
      @required this.price,
      @required this.category,
      @required this.photo});
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      
      name: json["name"],
      description: json["description"],
      type: json["type"],
      time: json["time"],
      price: json["price"],
      category: json["category"],
      photo: json["photo"],
    );
  }
}

*/

// To parse this JSON data, do
//
//     final foodModel = foodModelFromJson(jsonString);

import 'dart:convert';

List<FoodModel> foodModelFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  FoodModel({
    this.name,
    this.image,
    this.description,
    this.time,
    this.price,
    this.category,
    this.type,
    this.photo,
  });

  File photo;
  String image;
  String name;
  String description;
  String time;
  String price;
  String category;
  List<String> type;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        name: json["name"],
        description: json["description"],
        time: json["time"],
        price: json["price"],
        category: json["category"],
        image: json["photo"],
        type: List<String>.from(json["type"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "time": time,
        "price": price,
        "category": category,
        "type": List<dynamic>.from(type.map((x) => x)),
        "photo": photo,
      };
}
