// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

List<LocationMapper> locationFromJson(String str) => List<LocationMapper>.from(
    json.decode(str).map((x) => LocationMapper.fromJson(x)));

String locationToJson(List<LocationMapper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationMapper {
  LocationMapper({
    this.id,
    this.lat,
    this.long,
    this.deviceId,
    this.timeStamp,
    this.v,
  });

  String? id;
  String? lat;
  String? long;
  String? deviceId;
  DateTime? timeStamp;
  int? v;

  factory LocationMapper.fromJson(Map<String, dynamic> json) => LocationMapper(
        id: json["_id"],
        lat: json["lat"],
        long: json["long"],
        deviceId: json["deviceId"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lat": lat,
        "long": long,
        "deviceId": deviceId,
        "timeStamp": timeStamp!.toIso8601String(),
        "__v": v,
      };
}
