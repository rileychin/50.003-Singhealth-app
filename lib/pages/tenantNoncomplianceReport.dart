import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singhealth_app/pages/tenantHome.dart';
import 'dart:typed_data';
import 'package:toast/toast.dart';

import '../custom_icons.dart';

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
  Uint8List imageData, resImageData;

  String incidentName;
  String location;
  String summary;
  String status;

  TextEditingController commentController = new TextEditingController();

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
      if (element['status'] == 'unresolved') {
        inc += element['incidentName'] + ':';
      }
    });

    inc = inc.substring(0, inc.length - 1);
    incidents = inc.split(':');
    setState(() {
      incidents = incidents;
    });
  }

  Future<void> displayImage() async {
    var path = firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .doc(dropdownValue);
    DocumentSnapshot docSnap = await path.get();
    DocumentSnapshot imageSnapshot =
        await path.collection('images').doc('incident_image').get();
    DocumentSnapshot resImageSnapshot =
        await path.collection('images').doc('resolution_image').get();

    incidentName = docSnap.data()['incidentName'];
    location = docSnap.data()['location'];
    summary = docSnap.data()['summary'];
    status = docSnap.data()['status'];

    imageData =
        new Uint8List.fromList(imageSnapshot.data()['data'].cast<int>());
    setState(() {
      image = Image.memory(imageData, width: 400, height: 400);
    });

    resImageData =
        new Uint8List.fromList(resImageSnapshot.data()['data'].cast<int>());
    setState(() {
      resImage = Image.memory(resImageData, width: 400, height: 400);
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
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
                title: Text('Viewing non-compliance reports for ${shopName}'),
              ),
              body:
                  SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.center,
                      child:               Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Column(
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
                                  items: incidents
                                      .map<DropdownMenuItem<String>>((String value) {
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
                                        child: image != null
                                            ? image
                                            : Text('No incident image')),
                                    Container(
                                        margin: EdgeInsets.all(50),
                                        child: resImage != null
                                            ? resImage
                                            : Text('No resolution image')),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: ElevatedButton(
                                      onPressed: uploadResolution,
                                      child: Text("Upload Resolution Photo"),
                                    )),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 300),
                                  child: TextField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Your comments on resolution'),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      onPressed: resolveIncident,
                                      child: Text("Resolve Incident"),
                                    )),
                                Container(
                                  margin: EdgeInsets.all(50),
                                  child: RaisedButton.icon(
                                    icon: Icon(CustomIcons.backward),
                                    label: Text("Go Back"),
                                    textColor: Colors.white,
                                    color: Colors.blue[300],
                                    onPressed: back,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
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
      Toast.show("No resolution image selected.", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      var path = firestoreInstance
          .collection('institution')
          .doc(institution)
          .collection('tenant')
          .doc(shopName)
          .collection('nonComplianceReport')
          .doc(dropdownValue);


      path.collection('images').doc('resolution_image').set({"data": resImageData});
      path.update({"status": "pending", "comments": commentController.text});
      path
          .collection('images')
          .doc('resolution_image')
          .set({"data": resImageData});

      back();
    }
  }

  void back() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => TenantHome(user: user)));
  }
}
