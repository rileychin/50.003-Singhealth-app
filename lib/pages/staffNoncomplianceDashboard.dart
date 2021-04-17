import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'staffDashboardIncidentDetails.dart';

class StaffNonComplianceDashboard extends StatefulWidget {
  @override
  StaffNonComplianceDashboard({Key key, this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;

  _StaffNonComplianceDashboardState createState() =>
      _StaffNonComplianceDashboardState(user, firestoreInstance);
}

class _StaffNonComplianceDashboardState
    extends State<StaffNonComplianceDashboard> {
  User user;
  FirebaseFirestore firestoreInstance;
  List<String> tenantList, incidentList;
  String institution, shopName, details;
  bool shopSelected = false;

  Uint8List incidentBytes, resolutionBytes;

  _StaffNonComplianceDashboardState(user, firestoreinstance) {
    this.user = user;
    this.firestoreInstance = firestoreinstance;
  }

  void initState() {
    super.initState();
    //future
  }

  Future<List<dynamic>> updateNonCompliance() async {
    DocumentReference docRef =
        firestoreInstance.collection('staff').doc(user.uid);
    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) =>
        {institution = snapshot.data()['institution']});
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .get();

    String inc = '';
    querySnapshot.docs.forEach((doc) {
      inc += doc['shopName'] + ':';
    });

    inc = inc.substring(0, inc.length - 1);
    tenantList = inc.split(":");
    setState(() {
      tenantList = tenantList;
    });
  }

  Future<void> getIncidents(int index) async {
    shopName = tenantList[index];
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .get();
    String unresolved = '';
    String pending = '';
    String resolved = '';

    querySnapshot.docs.forEach((doc) {
      if (doc['status'] == 'unresolved') {
        unresolved += doc['incidentName'] + ':';
      } else if (doc['status'] == 'pending') {
        pending += doc['incidentName'] + ':';
      } else if (doc['status'] == 'resolved') {
        resolved += doc['incidentName'] + ':';
      }
    });
    if (unresolved.length > 0) {
      unresolved = unresolved.substring(0, unresolved.length - 1);
    }
    if (pending.length > 0) {
      pending = pending.substring(0, pending.length - 1);
    }
    if (resolved.length > 0) {
      resolved = resolved.substring(0, resolved.length - 1);
    }
    incidentList = ['Unresolved Incidents'] +
        unresolved.split(":") +
        ['Pending Confirmation'] +
        pending.split(":") +
        ['Resolved Incidents'] +
        resolved.split(":");
    setState(() {
      incidentList = incidentList;
      shopSelected = true;
    });
  }

  bool incidentTitle(String listItem) {
    if (listItem == 'Unresolved Incidents' ||
        listItem == 'Pending Confirmation' ||
        listItem == 'Resolved Incidents') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: updateNonCompliance(),
      builder: (context, snapshot) {
        if (tenantList == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (shopSelected == false) {
            return Scaffold(
              appBar: AppBar(
                  title: Text("Non Compliance Dashboard"),
                  backgroundColor: Colors.amber),
              body: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(200.0, 16.0, 200.0, 16.0),
                  itemCount: tenantList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 600.0),
                        child: Container(
                            height: 50,
                            color: Colors.amber[200],
                            child: RawMaterialButton(
                                child: Center(
                                    child: Text(tenantList[index].toString())),
                                onPressed: () {
                                  getIncidents(index);
                                })),
                      ),
                    );
                  }),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                    title: Text("Non Compliance Report"),
                    backgroundColor: Colors.amber),
                body: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(200.0, 16.0, 200.0, 16.0),
                  itemCount: incidentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 300.0),
                          child: Container(
                              height: 50,
                              color: incidentTitle(incidentList[index])
                                  ? Colors.amber[300]
                                  : Colors.amber[100],
                              child: RawMaterialButton(
                                child: Center(
                                  child: Text(incidentList[index]),
                                ),
                                onPressed: incidentTitle(incidentList[index])
                                    ? null
                                    : () {
                                        navigateToIncidentDetails(
                                            incidentList[index]);
                                      },
                              )),
                        ),
                      ],
                    );
                  },
                ));
          }
        }
      });
  void navigateToIncidentDetails(String incidentName) async {
    DocumentReference docRef = firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .doc(incidentName);
    DocumentSnapshot docSnap = await docRef.get();
    details =
        "Location: ${docSnap.data()['location']}\nSummary: ${docSnap.data()['summary']}\nStatus: ${docSnap.data()['status']}";
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('institution')
        .doc(institution)
        .collection('tenant')
        .doc(shopName)
        .collection('nonComplianceReport')
        .doc(incidentName)
        .collection('images')
        .get();
    querySnapshot.docs.forEach((element) {
      if (element.id == "incident_image") {
        //print(element.data()['data']);
        incidentBytes = Uint8List.fromList(element.data()['data'].cast<int>());
        //print(incidentImage);
      } else if (element.id == "resolution_image") {
        if (element.data()['data'] != null) {
          resolutionBytes =
              Uint8List.fromList(element.data()['data'].cast<int>());
        }
      }
    });
    print(docSnap.id);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StaffDashboardIncidentDetails(
                user: user,
                details: details,
                incidentName: incidentName,
                incidentBytes: incidentBytes,
                resolutionBytes: resolutionBytes,
                firestoreInstance: firestoreInstance,
                docRef: docRef)));
    setState(() {
      shopSelected = false;
    });
    incidentBytes = null;
    resolutionBytes = null;
  }
}
