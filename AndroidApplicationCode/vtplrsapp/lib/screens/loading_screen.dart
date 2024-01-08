// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vtplrsapp/mappers/Location.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vtplrsapp/services/LocationService.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.user, this.lat, this.long, this.area});
  String? area;
  double? lat;
  double? long;
  User? user;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    fetchHistory();
    createMarkers();
    print(markers);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: widget.user,
        lat: widget.lat,
        long: widget.long,
        area: widget.area,
      );
    }));
  }

  Set<Marker>? markers;
  //
  List<LocationMapper>? _historyList;
  bool? loader;
  List<String> _cities = [];
  LocationService locationService = new LocationService();
  Future<String> getRealAddress(double lt, double lg) async {
// From coordinates
//     final coordinates = new Coordinates(
//       lt,
//       lg,
//     );
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // return addresses.first.subLocality.toString();
    List<Placemark> placemarks = await placemarkFromCoordinates(lt, lg);
    return placemarks.first.subLocality.toString();
  }

  Future fetchHistory() async {
    setState(() {
      loader = true;
    });
    var response = await locationService.getLocationHistory();
    print(response);
    // var city;
    if (response != null) {
      setState(() {
        var historyList = locationFromJson(response);
        _historyList = new List.from(historyList.reversed);
      });
    } else {
      _historyList = null;
    }

    //creating cities
    if (_historyList != null) {
      await Future.wait(_historyList!.map((e) async {
        var city =
            await getRealAddress(double.parse(e.lat!), double.parse(e.long!));
        _cities.add(city);
      }));
      setState(() {
        loader = false;
      });
    } else {
      setState(() {
        loader = false;
      });
    }

    //print
    print(_cities);
  }

//creating markers;
  void createMarkers() async {
    int i = 0;
    await Future.wait(_historyList!.map((element) async {
      setState(() {
        markers!.add(Marker(
            markerId: MarkerId(element.id!),
            position:
                LatLng(double.parse(element.lat!), double.parse(element.long!)),
            draggable: true,
            infoWindow: InfoWindow(title: _cities[i], snippet: "Local Area")));
        i++;
      });
    }));
  }
  // lat=21.25
  //long=79.1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
