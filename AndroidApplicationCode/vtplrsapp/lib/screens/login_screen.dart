import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vtplrsapp/mappers/Location.dart';
import 'package:vtplrsapp/screens/RecoverPasswordScreen.dart';
import 'package:vtplrsapp/screens/loading_screen.dart';
import 'package:vtplrsapp/services/LocationService.dart';
import 'package:vtplrsapp/services/LoginService.dart';
import 'dashboard_screen.dart';
import 'package:vtplrsapp/utilities/constant.dart';
import 'package:vtplrsapp/utilities/input_field.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String textLable = "User Name";
  final String mainLable = "Login";

  String? email;
  String? password;

  double? lt;
  double? lg;
  String? ar;
  Marker? marker;
  bool? loader;
  void getLastLocation() async {
    LocationService locatioService = new LocationService();
    var response = await locatioService.getLocationHistory();
    List<LocationMapper> historyList = locationFromJson(response);
    var lastLocation = historyList.last;
    lt = double.parse(lastLocation.lat!);
    lg = double.parse(lastLocation.long!);
    // final coordinates = new Coordinates(
    //     double.parse(lastLocation.lat!), double.parse(lastLocation.long!));
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lastLocation.lat!), double.parse(lastLocation.long!));
    // var addresses =
    // await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // ar = addresses.first.subLocality;
    ar = placemarks.first.subLocality;
    print(ar);
  }

  @override
  void initState() {
    setState(() {
      loader = true;
      getLastLocation();
      loader = false;
    });
    super.initState();
  }

  void loginUser() async {
    LoginService loginService =
        new LoginService(email: email, password: password);
    var user = await loginService.doLogin();
    // print(user.name);
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Dashboard(user: user, lat: lt, long: lg, area: ar);
      }));
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ALERT",
        desc: "Username or Password is incorrect or something Went Wrong",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VTPLRS", style: TextStyle(color: kAppColor)),
      ),
      body: (loader)!
          ? SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '$mainLable',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Enter Email',
                          hintText: 'Email'),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Enter Password',
                          hintText: 'Password'),
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
                        child: Text(
                          'Login',
                          style: TextStyle(color: kAppColor, fontSize: 20),
                        ),
                        onPressed: () {
                          loginUser();
                        },
                      )),
                  RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RecoverPassword();
                        }));
                      },
                      child: Text("Forgot Password?"))
                ],
              )),
    );
  }
}
