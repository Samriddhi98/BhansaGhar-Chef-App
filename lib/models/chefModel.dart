// To parse this JSON data, do
//
//     final chef = chefFromJson(jsonString);

import 'dart:convert';

Chef chefFromJson(String str) => Chef.fromJson(json.decode(str));

String chefToJson(Chef data) => json.encode(data.toJson());

class Chef {
  Chef({
    this.role,
    this.id,
    this.name,
    this.username,
    this.email,
    this.contact,
    this.location,
    this.account,
    this.createdAt,
    this.verified,
    this.v,
  });

  String role;
  String id;
  String name;
  String username;
  String email;
  int contact;
  String location;
  int account;
  String createdAt;
  bool verified;
  int v;

  Chef get data {
    return Chef();
  }

  factory Chef.fromJson(Map<String, dynamic> json) => Chef(
        role: json["role"],
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        verified: json["verified"],
        email: json["email"],
        contact: json["contact"],
        location: json["location"],
        account: json["account"],
        createdAt: json["createdAt"],
        //  v: json["-v"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "verified": verified,
        "contact": contact,
        "location": location,
        "account": account,
        "createdAt": createdAt,
        // "-v": v,
      };
}
