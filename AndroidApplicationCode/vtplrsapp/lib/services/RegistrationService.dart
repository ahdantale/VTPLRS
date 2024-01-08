import 'dart:convert';

import 'package:vtplrsapp/utilities/constant.dart';
import 'package:http/http.dart' as http;

class RegistrationService {
  RegistrationService(
      {this.name,
      this.password,
      this.email,
      this.phoneNo,
      this.age,
      this.deviceId});
  String? name;
  String? password;
  String? email;
  String? phoneNo;
  String? age;
  String? deviceId;

  Future doRegistration() async {
    var url = Uri(
        scheme: 'http', host: '10.0.2.2', port: 4000, path: '/user/createUser');
    var url2 = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 4000,
        path: '/device/registerDevice');
    print(url);
    print(url2);

    // var url = Uri.parse("http://127.0.0.1:4000/user/createUser");
    try {
      if (name == "" &&
          password == "" &&
          email == "" &&
          phoneNo == "" &&
          age == "" &&
          deviceId == "") {
        return false;
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "name": name,
            "password": password,
            "email": email,
            "phoneNo": int.parse(phoneNo!),
            "age": int.parse(age!)
          }));
      final response2 = await http.post(url2,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "deviceId": deviceId,
            "email": email,
          }));
      if (200 == response.statusCode && 200 == response2.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
