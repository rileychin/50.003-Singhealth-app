import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:typed_data';

import 'package:toast/toast.dart';

class TenantViewNoncompliance extends StatefulWidget {
  final User user;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  TenantViewNoncompliance({Key key, this.user}) : super(key: key);

  @override
  _TenantViewNoncomplianceState createState() =>
      _TenantViewNoncomplianceState(user, firestoreInstance);
}

class _TenantViewNoncomplianceState extends State<TenantViewNoncompliance> {
  String dropdownValue;
  List<String> incidents = [''];
  User user;
  FirebaseFirestore firestoreInstance;
  String shopName, institution;
  QuerySnapshot incidentData;
  Image image, resImage;
  Uint8List imgData, resImageData;

  String incidentName;
  String location;
  String summary;
  String status;

  _TenantViewNoncomplianceState(user, firestoreInstance) {
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }

  Future<void> updateIncidentData() async {
    DocumentSnapshot documentSnapshot =
    await firestoreInstance.collection('tenant').doc(user.uid).get();
    shopName = documentSnapshot.data()['shopName'];
    institution = documentSnapshot.data()['institution'];
    incidentData = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .get();

    // updateIncidentList() merged
    String inc = '';
    incidentData.docs.forEach((element) {
      inc += element['incidentName'] + ':';
    });
    inc = inc.substring(0, inc.length - 1);
    incidents = inc.split(':');
    setState(() {
      incidents = incidents;
    });
  }

  Future<void> displayImage() async {
    DocumentSnapshot docSnap = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .doc(dropdownValue)
        .get();


    incidentName = docSnap.data()['incidentName'];
    location = docSnap.data()['location'];
    summary = docSnap.data()['summary'];
    status = docSnap.data()['status'];

    imgData = new Uint8List.fromList(docSnap.data()['data'].cast<int>());
    setState(() {
      image = Image.memory(imgData);
    });
  }

  @override
  Widget build(BuildContext context) =>
      FutureBuilder(
          future: updateIncidentData(),
          builder: (context, snapshot) {
            if (incidentData == null) {
              return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(
                        'Viewing non-compliance reports for ${shopName}'),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        hint: new Text('Incident Name'),
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                          displayImage();
                        },
                        items:
                        incidents.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      Text("Incident Name: $incidentName"),
                      Text("Summary: $summary"),
                      Text("Location: $location"),
                      Text("Status: $status"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.all(50),
                              child: image == null ? Text('No image selected') : image
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(50),
                                child: resImage == null ? Text('No image selected') : resImage,
                              ),
                              ElevatedButton(
                                onPressed: uploadResolution,
                                child: Text("Upload Resolution Photo"),
                              ),
                              ElevatedButton(
                                onPressed: resolveIncident,
                                child: Text("Resolve Incident"),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
              );
            }
          });

  Future<void> uploadResolution() async {
    FilePickerResult picked = await FilePicker.platform.pickFiles();
    this.resImageData = picked.files.single.bytes;

    setState(() {
      this.resImage = Image.memory(this.resImageData, width: 400, height: 400);
    });
  }

  Future<void> resolveIncident() async {
    if (this.resImageData == null) {
      Toast.show("No resolution image selected.", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      firestoreInstance.collection('institution').doc(institution).collection('tenant').doc(shopName).collection('nonComplianceReport').doc(dropdownValue).set({
        "incidentName": incidentName,
        "location": location,
        "summary": summary,
        "status": "resolved",
        "data": imgData,
        "resImage_data": resImageData,
      });

      displayImage();
    }
  }
}
