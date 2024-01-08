import 'package:flutter/material.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import "package:vtplrsapp/utilities/input_field.dart";
import '../utilities/app_drawer.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({this.user});
  final User? user;

  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  String? name, email;
  int? phoneNo, age;
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.user!.name;
    phoneNo = widget.user!.phoneNo;
    email = widget.user!.email;
    age = widget.user!.age;
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
            "Profile",
            style: TextStyle(color: kAppColor),
          ),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1528660493888-ab6f4761e036?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"),
                ),
              ),
              Container(
                color: kContainerColors,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.user,
                      color: kAppColor,
                    ),
                    SizedBox(width: 20),
                    Text("$name", style: kProfiltextStyle)
                  ],
                ),
              ),
              Container(
                color: kContainerColors,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.phone,
                      color: kAppColor,
                    ),
                    SizedBox(width: 20),
                    Text("$phoneNo", style: kProfiltextStyle)
                  ],
                ),
              ),
              Container(
                color: kContainerColors,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.mailBulk,
                      color: kAppColor,
                    ),
                    SizedBox(width: 20),
                    Text("$email", style: kProfiltextStyle)
                  ],
                ),
              ),
              Container(
                color: kContainerColors,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.birthdayCake,
                      color: kAppColor,
                    ),
                    SizedBox(width: 20),
                    Text("$age", style: kProfiltextStyle)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
