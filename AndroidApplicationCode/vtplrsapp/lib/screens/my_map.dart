import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vtplrsapp/mappers/Location.dart';
import 'package:vtplrsapp/services/LocationService.dart';

class Load_Map extends StatefulWidget {
  Load_Map({this.lat, this.long, this.area, this.marker});
  String? area;
  double? lat;
  double? long;
  Marker? marker;
  @override
  _Load_MapState createState() => _Load_MapState();
}

class _Load_MapState extends State<Load_Map> {
  GoogleMapController? mapController;
  Set<Marker> _marker = {};
  String? ar;
  double? lt;
  double? lg;

  final LatLng _center = const LatLng(20.5937, 78.9629);
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      ar = widget.area;
      lt = widget.lat;
      lg = widget.long;
      _marker.add(widget.marker!);
    });

    print(_marker);
    super.initState();
    // moveToNew(mapController);
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
    mapController!
        .moveCamera(CameraUpdate.newLatLng(LatLng(widget.lat!, widget.long!)));
    //  print(_marker);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _marker.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15,
        ),
        myLocationButtonEnabled: true,
        markers: _marker,
      ),
    );
  }
}
