import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:toast/toast.dart';

class StaffTenantDetailsThree extends StatefulWidget {
  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffTenantDetailsThree(
      {Key key, this.user, this.staff, this.tenantReference, this.tenantName})
      : super(key: key);

  @override
  _StaffTenantDetailsThreeState createState() =>
      _StaffTenantDetailsThreeState(user, staff, tenantReference, tenantName);
}

class _StaffTenantDetailsThreeState extends State<StaffTenantDetailsThree> {
  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  DocumentReference tenantReference;
  String tenantName;
  int numEmployees = 0;
  dynamic tenantInfo;

  _StaffTenantDetailsThreeState(user, staff, tenantReference, tenantName) {
    this.user = user;
    this.staff = staff;
    this.tenantReference = tenantReference;
    this.tenantName = tenantName;
  }

  getTenantInfo() async {
    await tenantReference.get().then<dynamic>((DocumentSnapshot snapshot) {
      setState(() {
        tenantInfo = snapshot.data();
      });
    });

    QuerySnapshot snapshot =
        await tenantReference.collection('employees').get();
    List<DocumentSnapshot> snapshotCount = snapshot.docs;
    setState(() {
      numEmployees = snapshotCount.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTenantInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (tenantInfo == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Tenant Details for $tenantName'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 400.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          tileColor: Colors.grey,
                          title: Center(
                            child: Text(
                              "Tenant Details for $tenantName: ",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Shop Name: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['shopName']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Institution: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${staff['institution']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Contract Expiry: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['contractExpiry']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Date Joined: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['dateJoined']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Unit Number: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['unitNumber']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Phone Number: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['phoneNumber']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Number of employees registered: "),
                            Container(
                              alignment: Alignment.center,
                              width: 350,
                              child: Text(
                                "$numEmployees",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
