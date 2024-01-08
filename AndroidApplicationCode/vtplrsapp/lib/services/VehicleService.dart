import 'dart:convert';
import 'package:vtplrsapp/mappers/VehicleImage.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'package:vtplrsapp/mappers/Vehicle.dart';

class VehicleService {
  VehicleService({this.email});
  String? email;

  Future getImage() async {
    var url2 = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 4000,
        path: '/photos/getPhoto/0123456789');
    print(url2);
    try {
      final response2 = await http.get(url2);
      if (response2.statusCode == 200) {
        final VehicleImage vehicleImage = imageFromJson(response2.body);
        return vehicleImage;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getVehicleData() async {
    var url = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 4000,
        path: '/vehicle/getVehicle');

    print(url);
    print(email);
    try {
      if (email == "") {
        return null;
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"email": email}));

      if (200 == response.statusCode) {
        final Vehicle vehicle = vehicleFromJson(response.body);
        return vehicle;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
