import 'package:flutter/material.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/screens/Add_Vehicle.dart';
import 'package:vtplrsapp/screens/LocationHistoryMap.dart';
import 'package:vtplrsapp/screens/dashboard_screen.dart';
import 'package:vtplrsapp/screens/home_screen.dart';
import 'package:vtplrsapp/screens/location_history.dart';
import 'package:vtplrsapp/screens/profile_page.dart';
import 'package:vtplrsapp/screens/report_thief.dart';
import 'package:vtplrsapp/screens/setting.dart';
import 'package:vtplrsapp/screens/vehicle_detail.dart';
import 'constant.dart';

class Load_Drawer extends StatefulWidget {
  const Load_Drawer({this.user});
  final User? user;

  @override
  _Load_DrawerState createState() => _Load_DrawerState();
}

class _Load_DrawerState extends State<Load_Drawer> {
  @override
  Widget build(BuildContext context) {
    String name = widget.user!.name!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "$name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Dashboard(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile_Page(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.location_history_rounded),
            title: Text('Location History Map',
                style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationHistoryMap(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.location_history_rounded),
            title: Text('Location History', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Location_History(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.bike_scooter),
            title: Text('Add Vehicle', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Add_Vehicle(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.bike_scooter),
            title: Text('Vehicle Details', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Vehicle_Detail(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Report Theft', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Report_Thief(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Setting(user: widget.user);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout', style: TextStyle(color: kAppColor)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => home_screen()),
                  ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
