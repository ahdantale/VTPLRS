import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/utilities/app_drawer.dart';
import 'package:vtplrsapp/utilities/constant.dart';

class Setting extends StatefulWidget {
  Setting({this.user});
  final User? user;
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kButtonColor,
        drawer: Load_Drawer(user: widget.user),
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(color: kAppColor),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Card(
                child: Container(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              "Notification Frequency",
                              style: TextStyle(color: kAppColor, fontSize: 21),
                            ),
                          ],
                        ))),
              ),
              Card(
                child: Container(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Types of Notifications",
                            style: TextStyle(color: kAppColor, fontSize: 21)))),
              ),
              Card(
                child: Container(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("About",
                            style: TextStyle(color: kAppColor, fontSize: 21)))),
              ),
              Card(
                child: Container(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Start/Stop service",
                            style: TextStyle(color: kAppColor, fontSize: 21)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
