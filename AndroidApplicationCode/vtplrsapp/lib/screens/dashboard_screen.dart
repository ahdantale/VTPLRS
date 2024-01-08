import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_background/flutter_background.dart';
// import 'package:flutter_dropdown_alert/alert_controller.dart';
// import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locally/locally.dart';
// import 'package:locally/locally.dart';
import 'package:vtplrsapp/mappers/Location.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/screens/home_screen.dart';
import 'package:vtplrsapp/screens/my_map.dart';
import 'package:vtplrsapp/screens/profile_page.dart';
import 'package:vtplrsapp/services/LocationService.dart';
import '../utilities/constant.dart';
import '../utilities/app_drawer.dart';

class Dashboard extends StatefulWidget {
  User? user;
  String? area;
  double? lat;
  double? long;
  // Set<Marker> markers;
  Dashboard({
    this.user,
    this.lat = 21.1962504,
    this.long = 79.0712471,
    this.area = "Farid Nagar",
  });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? userData;
  Marker? marker;
  bool? loader;

  var timer;
  int? length;
  List<LocationMapper>? historyList;
  double? lt;
  double? lg;
  String? ar;
  void getLastLocation() async {
    // print(historyList.last.timeStamp);

    LocationService locatioService = new LocationService();
    var response = await locatioService.getLocationHistory();
    setState(() {
      historyList = locationFromJson(response);
    });

    print(historyList);
    var lastLocation = historyList!.last;
    if (lt != null && lg != null) {
      if (lt != double.parse(lastLocation.lat.toString()) &&
          lg != double.parse(lastLocation.long.toString())) {
        show();
        setState(() {
          lt = double.parse(lastLocation.lat.toString());
          lg = double.parse(lastLocation.long.toString());
        });
      }
    } else {
      setState(() {
        lt = double.parse(lastLocation.lat.toString());
        lg = double.parse(lastLocation.long.toString());
      });
    }
  }

  void show() async {
    print("hello");
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(historyList!.last.lat!),
        double.parse(historyList!.last.long!));
    Locally locally = Locally(
      context: context,
      payload: 'test',
      pageRoute: MaterialPageRoute(
          builder: (context) => Dashboard(
                user: widget.user,
                lat: double.parse(historyList!.last.lat!),
                long: double.parse(historyList!.last.long!),
                area: placemarks.first.subLocality,
              )),
      appIcon: 'mipmap/ic_launcher',
    );

    locally.show(title: "Updates", message: "Location Updated");
  }

  //this init
  @override
  void initState() {
    // TODO: implement initState
    // fetchRealTime();
    timer =
        Timer.periodic(Duration(minutes: 1), (Timer t) => {getLastLocation()});
    setState(() {
      loader = true;
    });
    super.initState();
    userData = widget.user;

    print(widget.area);
    print(widget.lat);
    marker = new Marker(
      markerId: MarkerId("id-1"),
      position: LatLng(widget.lat!, widget.long!),
      draggable: true,
      infoWindow: InfoWindow(title: "${widget.area}", snippet: "Local Area"),
    );
    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VTPLRS', style: TextStyle(color: kAppColor)),
      ),
      drawer: Load_Drawer(user: widget.user),
      // drawer: Load_Drawer(),
      body: loader!
          ? SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            )
          : Center(
              child: Load_Map(
              lat: widget.lat,
              long: widget.long,
              area: widget.area,
              marker: marker,
            )),
    );
  }
}
