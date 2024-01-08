import 'dart:convert';
import 'dart:typed_data';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class AddVehicleService {
  AddVehicleService(
      {this.make,
      this.model,
      this.colour,
      this.registration,
      this.email,
      this.images});
  String? make, model, colour, registration, email;
  List<Asset>? images = <Asset>[];
  var dio = Dio();

  Future addVehicle() async {
    var url = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 4000,
        path: '/vehicle/addVehicle');

    String url2 = "http://10.0.2.2:4000/photos/saveVehiclePhotos";

    try {
      if (make == "" &&
          model == "" &&
          colour == "" &&
          registration == "" &&
          email == "") {
        return null;
      }
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "make": make,
            "model": model,
            "registration": registration,
            "colour": colour,
            "email": email
          }));

      // final response2 = await http.post(url2,
      //     headers: {"Content-Type": "multipart/form-data"},
      //     body: {"img": images, "type": "jpg", "deviceId": "0123456789"});
      //image process
      var response2;
      if (images != null) {
        for (var i = 0; i < images!.length; i++) {
          ByteData byteData = await images![i].getByteData();
          List<int> imageData = byteData.buffer.asUint8List();

          MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
              filename: images![i].name, contentType: MediaType('image', "jpg"));
          FormData formData = FormData.fromMap(
              {"img": multipartFile, "type": "png", "deviceId": "0123456789"});
          response2 = await dio.post(url2, data: formData);
        }
      }

      if (200 == response.statusCode && response2.statusCode == 200) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
