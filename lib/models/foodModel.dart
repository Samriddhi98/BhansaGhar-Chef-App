import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';

class FoodModel {
  File photo;
  String name,
      description,
      type,
      time,
      price,
      category;
  
 
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