import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class StaffDashboardIncidentDetails extends StatefulWidget {
  @override
  StaffDashboardIncidentDetails({
    Key key,
    this.user,
    this.details,
    this.incidentName,
    this.incidentBytes,
    this.resolutionBytes}) : super(key: key);

  final User user;
  final String incidentName,details;
  final Uint8List incidentBytes,resolutionBytes;
  final firestoreInstance = FirebaseFirestore.instance;

  _StaffDashboardIncidentDetailsState createState() => _StaffDashboardIncidentDetailsState(user, details, incidentName, incidentBytes, resolutionBytes);
}

class _StaffDashboardIncidentDetailsState extends State<StaffDashboardIncidentDetails>{
  User user;
  String details,incidentName;
  Image incidentImage,resolutionImage;


  _StaffDashboardIncidentDetailsState(User user,String details, String incidentName, Uint8List incidentBytes, Uint8List resolutionBytes) {
    this.user = user;
    this.details = details;
    this.incidentName = incidentName;
    this.incidentImage = Image.memory(incidentBytes);
    if(resolutionBytes != null) {
      this.resolutionImage = Image.memory(resolutionBytes);
    }


  }
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber,
                title: Text('Noncompliance Incident Details'),
              ),
              body: Column(
                children: [
                  Container(
                    child: Text(incidentName),
                    color: Colors.amber
                  ),
                  Container(
                    child: Text(details),
                    color: Colors.amber[200]
                  ),
                  Row(
                    children: [
                      Container(
                        child: incidentImage != null ? incidentImage : Text("No image")
                      ),
                      Container(
                        child: resolutionImage != null ? resolutionImage : Text("No image")
                      )
                    ],
                  )


                ],
              )
            );
          }



}
