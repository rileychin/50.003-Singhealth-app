import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:typed_data';

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
  Image image;

  _TenantViewNoncomplianceState(user, firestoreInstance) {
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }

  Future<void> updateIncidentData() async {
    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection('tenant').doc(user.uid).get();
    print(documentSnapshot.data());
    shopName = documentSnapshot.data()['shopName'];
    institution = documentSnapshot.data()['institution'];
    incidentData = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .get();
  }

  void updateIncidentList() {
    //todo: basically automate this shit
    print(incidentData);
    String inc = '';
    incidentData.docs.forEach((element) {
      inc += element['incidentName'] + ':';
    });
    inc = inc.substring(0, inc.length - 1);
    incidents = inc.split(':');
    print(incidents);
    setState(() {
      incidents = incidents;
    });
  }

  Future<void> displayImage() async {

    DocumentSnapshot docSnap = await firestoreInstance.collection('institution').doc(institution).collection('tenant').doc(shopName).collection('nonComplianceReport').doc(dropdownValue).get();

    Uint8List imgData = new Uint8List.fromList(docSnap.data()['data'].cast<int>());
    setState(() {
      image = Image.memory(imgData);
    });
  }

  Widget build(BuildContext context) {
    //todo: add check for incidents != null
    updateIncidentData();
    return Scaffold(
        body: Column(
      children: [
        RawMaterialButton(
          child: Text('update incidents'),
          onPressed: updateIncidentList,
        ),
        DropdownButton<String>(
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
          },
          items: incidents.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        RawMaterialButton(
          child: Text('display image'),
          onPressed: displayImage,
        ),
        Container(
          child: (image == null) ? Text('No image selected') : image,
        )
      ],
    ));
  }
}
