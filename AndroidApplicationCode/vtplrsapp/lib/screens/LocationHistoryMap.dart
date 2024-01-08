import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vtplrsapp/mappers/Location.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/services/LocationService.dart';
import 'package:vtplrsapp/utilities/app_drawer.dart';
import 'package:vtplrsapp/utilities/constant.dart';

class LocationHistoryMap extends StatefulWidget {
  LocationHistoryMap({this.user});
  User? user;

  @override
  _LocationHistoryMapState createState() => _LocationHistoryMapState();
}

class _LocationHistoryMapState extends State<LocationHistoryMap> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(21.1962504, 79.0712471);
  List<Marker> _marker = [];

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
    } else {
      setState(() {
        loader = false;
      });
    }
    //print
    print(_cities);
    if (_historyList != null) {
      _marker.clear();
      for (int i = 0; i < _historyList!.length; i++) {
        MarkerId markerId = new MarkerId(i.toString());
        _marker.add(
          new Marker(
              markerId: markerId,
              onTap: () {},
              position: LatLng(double.parse(_historyList![i].lat!),
                  double.parse(_historyList![i].long!)),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet),
              infoWindow:
                  InfoWindow(title: _cities[i], snippet: "Visited Place")),
        );
      }
      setState(() {
        loader = false;
      });
    } else {
      setState(() {
        loader = false;
      });
    }
    print(_marker);
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    fetchHistory();
    // _initMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Load_Drawer(user: widget.user),
      backgroundColor: kButtonColor,
      appBar: AppBar(
        title: Text(
          "Location History",
          style: TextStyle(color: kAppColor),
        ),
      ),
      body: loader!
          ? SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13,
              ),
              myLocationButtonEnabled: true,
              markers: _marker.toSet(),
            ),
    );
  }
}
