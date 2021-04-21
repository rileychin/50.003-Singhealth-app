import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/pages/staffNoncomplianceDashboard.dart';


class StaffDashboardIncidentDetails extends StatefulWidget {
  @override
  StaffDashboardIncidentDetails({
    Key key,
    this.user,
    this.details,
    this.incidentName,
    this.incidentBytes,
    this.resolutionBytes,
    this.firestoreInstance,
    this.status,
    this.docRef}) : super(key: key);

  final User user;
  final String incidentName,details,status;
  final Uint8List incidentBytes,resolutionBytes;
  final firestoreInstance,docRef;


  _StaffDashboardIncidentDetailsState createState() => _StaffDashboardIncidentDetailsState(user, details, incidentName, incidentBytes, resolutionBytes, firestoreInstance, status, docRef);
}

class _StaffDashboardIncidentDetailsState
    extends State<StaffDashboardIncidentDetails> {
  User user;
  String details,incidentName,status;
  Image incidentImage,resolutionImage;
  FirebaseFirestore firestoreInstance;
  DocumentReference docRef;


  _StaffDashboardIncidentDetailsState(User user,String details, String incidentName, Uint8List incidentBytes, Uint8List resolutionBytes, FirebaseFirestore firestoreInstance, String status, DocumentReference docRef) {
    this.user = user;
    this.details = details;
    this.incidentName = incidentName;
    this.incidentImage = Image.memory(incidentBytes);
    if (resolutionBytes != null) {
      this.resolutionImage = Image.memory(resolutionBytes);
    }
    this.firestoreInstance = firestoreInstance;
    this.status = status;
    this.docRef = docRef;
  }

  void initState() {
    super.initState();

  }

  void approve() {
    docRef.update({'status': 'resolved'});
    back();
  }

  void reject() {
    docRef.update({'status': 'unresolved'});
    docRef.collection("images").doc("resolution_image").delete();
    back();
  }

  void deleteIncident() {
    docRef.collection("images").doc("incident_image").delete();
    docRef.delete();
    back();
  }

  void back() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => StaffNonComplianceDashboard(user: user)));
  }

  // child: LayoutBuilder(
  // builder: (BuildContext context, BoxConstraints viewportConstraints) {
  // return SingleChildScrollView(
  // child: ConstrainedBox(
  // constraints: BoxConstraints(
  // minHeight: viewportConstraints.maxHeight,
  // ),

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
            ),
            Container(
                child: status == 'pending' ? Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: approve,
                          child: Text("Approve Resolution"),
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: reject,
                          child: Text("Reject Resolution"),
                        )),
                  ],
                ) : null
            ),
            Container(
                child: status == 'unresolved' ? Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: deleteIncident,
                          child: Text("Delete Incident"),
                        )),
                  ],
                ) : null
            )
          ],
        )
    );
  }
}
