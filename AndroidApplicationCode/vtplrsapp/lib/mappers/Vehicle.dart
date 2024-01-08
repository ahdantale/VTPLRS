// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  Vehicle({
    this.id,
    this.make,
    this.model,
    this.colour,
    this.registration,
    this.email,
  });

  String? id;
  String? make;
  String? model;
  String? colour;
  String? registration;
  String? email;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["_id"],
        make: json["make"],
        model: json["model"],
        colour: json["colour"],
        registration: json["registration"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "make": make,
        "model": model,
        "colour": colour,
        "registration": registration,
        "email": email,
      };
}
