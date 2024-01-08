import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/mappers/Vehicle.dart';
import 'package:vtplrsapp/mappers/VehicleImage.dart';
import 'package:vtplrsapp/services/VehicleService.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import "package:vtplrsapp/utilities/input_field.dart";
import '../utilities/app_drawer.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Vehicle_Detail extends StatefulWidget {
  Vehicle_Detail({this.user});
  final User? user;
  @override
  _Vehicle_DetailState createState() => _Vehicle_DetailState();
}

class _Vehicle_DetailState extends State<Vehicle_Detail> {
  Vehicle? vehicle;
  VehicleImage? image;
  Uint8List? bytes;
  bool load = true;
  void fetchData() async {
    VehicleService vehicleService =
        new VehicleService(email: widget.user!.email);
    var response1 = await vehicleService.getVehicleData();
    var response2 = await vehicleService.getImage();
    if (response1 != null && response2 != null) {
      // print(response1);
      // print(response2);
      // print(vehicle.id);
      // print(image.imageString);
      setState(() {
        vehicle = response1;
        image = response2;
        bytes = Base64Codec().decode(image!.imageString!);
      });
      load = false;
      // print(bytes);
    } else {
      print("Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var kProfiltextStyle = TextStyle(color: kAppColor, fontSize: 20);
    var kContainerColors = Colors.black;
    return Container(
      child: Scaffold(
        drawer: Load_Drawer(user: widget.user),
        appBar: AppBar(
          title: Text(
            "Vehicle Details",
            style: TextStyle(color: kAppColor),
          ),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: load
              ? Text("Loading")
              : ListView(
                  children: <Widget>[
                    Container(
                      color: kContainerColors,
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.biking,
                            color: kAppColor,
                          ),
                          SizedBox(width: 20),
                          Text(vehicle!.model!, style: kProfiltextStyle)
                        ],
                      ),
                    ),
                    Container(
                      color: kContainerColors,
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.rProject,
                            color: kAppColor,
                          ),
                          SizedBox(width: 20),
                          Text(vehicle!.make!, style: kProfiltextStyle)
                        ],
                      ),
                    ),
                    Container(
                      color: kContainerColors,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.info,
                            color: kAppColor,
                          ),
                          SizedBox(width: 20),
                          Text(vehicle!.colour!, style: kProfiltextStyle)
                        ],
                      ),
                    ),
                    Container(
                      color: kContainerColors,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.registered,
                            color: kAppColor,
                          ),
                          SizedBox(width: 20),
                          Text(vehicle!.registration!, style: kProfiltextStyle)
                        ],
                      ),
                    ),
                    Container(
                      color: kContainerColors,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Row(
                        children: <Widget>[
                          Text("Photos", style: kProfiltextStyle)
                        ],
                      ),
                    ),
                    Container(
                      color: kContainerColors,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Card(
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Container(
                              // width: 300,
                              // height: 100,
                              child: bytes == null
                                  ? Text("Images")
                                  : Image.memory(
                                      bytes!,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
