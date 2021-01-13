import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FoodModel {
  String name,
      description,
      type,
      time,
      price,
      category,
      photo;

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