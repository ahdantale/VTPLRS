import 'dart:convert';

// import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:vtplrsapp/mappers/Location.dart';
class LocationService {
  LocationService();

  Future getLocationHistory() async {
    var url = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 4000,
        path: '/location/getLocationForDevice');
    print(url);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"deviceId": "0123456789"}));
      print(response.body);
      print(response.statusCode);

      String city;
      if (200 == response.statusCode) {
        // List<LocationMapper> historyList = locationFromJson(response.body);

        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
