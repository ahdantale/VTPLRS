import 'dart:convert';

import 'package:vtplrsapp/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'package:vtplrsapp/mappers/User.dart';

class LoginService {
  LoginService({this.email, this.password});
  String? email;
  String? password;
  Future doLogin() async {
    var url = Uri(
        scheme: 'http', host: '10.0.2.2', port: 4000, path: '/user/loginUser');
    print(url);
    // var url = Uri.parse("http://127.0.0.1:4000/user/createUser");
    try {
      if (email == "" && password == "") {
        return null;
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"email": email, "password": password}));
      if (200 == response.statusCode) {
        final User user = userFromJson(response.body);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
