// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

VehicleImage imageFromJson(String str) =>
    VehicleImage.fromJson(json.decode(str));

String imageToJson(VehicleImage data) => json.encode(data.toJson());

class VehicleImage {
  VehicleImage({
    this.imageString,
    this.deviceId,
  });

  String? imageString;
  String? deviceId;

  factory VehicleImage.fromJson(Map<String, dynamic> json) => VehicleImage(
        imageString: json["imageString"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "imageString": imageString,
        "deviceId": deviceId,
      };
}
