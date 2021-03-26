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
    this.institution,
    this.shopName,
    this.incidentName}) : super(key: key);

  final User user;
  final String institution,shopName,incidentName;
  final firestoreInstance = FirebaseFirestore.instance;

  _StaffDashboardIncidentDetailsState createState() => _StaffDashboardIncidentDetailsState(user, institution, shopName, incidentName, firestoreInstance);
}

class _StaffDashboardIncidentDetailsState extends State<StaffDashboardIncidentDetails>{
  User user;
  String institution,shopName,incidentName,detailsString;
  FirebaseFirestore firestoreInstance;
  Image incidentImage,resolutionImage;
  Uint8List incidentBytes,resolutionBytes;

  _StaffDashboardIncidentDetailsState(User user,String institution, String shopName, String incidentName, FirebaseFirestore firestoreInstance) {
    this.user = user;
    this.institution = institution;
    this.shopName = shopName;
    this.incidentName = incidentName;
    this.firestoreInstance = firestoreInstance;
  }
  void initState(){
    super.initState();
  }

  Future<void> updateIncidentDetails() async {
    
    await firestoreInstance.collection('institution').doc(institution).collection('tenant').doc(shopName).collection('nonComplianceReport').doc(incidentName).get().then((doc){
      detailsString = "Summary: ${doc.data()['summary']}\nLocation: ${doc.data()['location']}\nStatus: ${doc.data()['status']}";
    });

    print(detailsString);
    
    await firestoreInstance.collection('institution').doc(institution).collection('tenant').doc(shopName).collection('nonComplianceReport').doc(incidentName).collection('images').get().then((qS){
      qS.docs.forEach((element) {
        if (element.id == "incident_image"){
          //print(element.data()['data']);
          incidentBytes = element.data()['data'];
          //print(incidentImage);
        } else if (element.id == "resolution_image") {
          if (element.data()['data'].exists) {
            resolutionBytes = element.data()['data'];
          }

        }
      });
    });
    

    print("a");
    if (detailsString != null && incidentBytes != null ) {
      setState(() {
        incidentImage = Image.memory(incidentBytes);
        detailsString = detailsString;
        if (resolutionBytes != null) {
          resolutionImage = Image.memory(resolutionBytes);
        }

      });
    }

  }

  @override
  Widget build(BuildContext context) =>
      FutureBuilder(
        future: updateIncidentDetails(),
        builder: (context,snapshot){
          if (detailsString == null) {
            return Center(child: CircularProgressIndicator());
          } else {
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
                    child: Text(detailsString),
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

        });

}
