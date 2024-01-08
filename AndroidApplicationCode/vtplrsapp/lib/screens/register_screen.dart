import 'package:flutter/material.dart';
import 'package:vtplrsapp/screens/dashboard_screen.dart';
import 'package:vtplrsapp/screens/loading_screen.dart';
import 'package:vtplrsapp/screens/login_screen.dart';
import 'package:vtplrsapp/services/RegistrationService.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import 'package:vtplrsapp/utilities/input_field.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String? name;
  String? password;
  String? email;
  String? phoneNo;
  String? age;
  String? deviceId;
  void registerUser() async {
    RegistrationService registrationService = new RegistrationService(
        name: name,
        password: password,
        email: email,
        phoneNo: phoneNo,
        age: age,
        deviceId: deviceId);
    try {
      var status = await registrationService.doRegistration();
      if (status == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserLogin();
        }));
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ALERT",
          desc: "Something Went Wrong",
          buttons: [
            DialogButton(
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      print(status);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: TextStyle(color: kAppColor)),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      deviceId = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Device-Id',
                      hintText: 'Device Id'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Name',
                      hintText: 'Name'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Email',
                      hintText: 'Email'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Password',
                      hintText: 'Password'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      phoneNo = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Phone Number',
                      hintText: 'Phone Number'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      age = value;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Enter Age',
                      hintText: 'Age'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    child: Text('Register',
                        style: TextStyle(color: kAppColor, fontSize: 20)),
                    onPressed: () {
                      registerUser();
                    },
                  )),
            ],
          )),
    );
  }
}
