import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vtplrsapp/mappers/User.dart';
import 'package:vtplrsapp/screens/PdfViewerPage.dart';
import 'package:vtplrsapp/services/PDFApi.dart';
import 'package:vtplrsapp/utilities/app_drawer.dart';
import 'package:vtplrsapp/utilities/constant.dart';

class Report_Thief extends StatefulWidget {
  Report_Thief({this.user});
  final User? user;
  @override
  _Report_ThiefState createState() => _Report_ThiefState();
}

class _Report_ThiefState extends State<Report_Thief> {
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kButtonColor,
        drawer: Load_Drawer(user: widget.user),
        appBar: AppBar(
          title: Text(
            "Report Theft",
            style: TextStyle(color: kAppColor),
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Card(
                  child: Container(
                      width: 300,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                              child: Text("F.I.R. Format",
                                  style: TextStyle(
                                      color: kAppColor, fontSize: 21)),
                              onPressed: () async {
                                var url = Uri(
                                    scheme: 'http',
                                    host: '10.0.2.2',
                                    port: 4000,
                                    path: '/payload/getComplaintFormat');

                                final file = await PDFApi.loadNetwork(url);
                                openPDF(context, file);
                              }))),
                ),
                Card(
                  child: Container(
                      width: 300,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Complaint Type",
                              style:
                                  TextStyle(color: kAppColor, fontSize: 21)))),
                ),
                Card(
                  child: Container(
                      width: 300,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Phone No",
                              style:
                                  TextStyle(color: kAppColor, fontSize: 21)))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
