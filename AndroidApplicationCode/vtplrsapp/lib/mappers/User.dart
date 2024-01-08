// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.phoneNo,
    this.email,
    this.age,
  });

  String? id;
  String? name;
  int? phoneNo;
  String? email;
  int? age;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        email: json["email"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phoneNo": phoneNo,
        "email": email,
        "age": age,
      };
}
