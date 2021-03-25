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

  StaffTenantDetailsThree({
    Key key,
    this.user,
    this.staff,
    this.tenantReference,
    this.tenantName}) : super(key: key);


  @override
  _StaffTenantDetailsThreeState createState() => _StaffTenantDetailsThreeState(user,staff,tenantReference,tenantName);
}

class _StaffTenantDetailsThreeState extends State<StaffTenantDetailsThree> {

  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  DocumentReference tenantReference;
  String tenantName;
  int numEmployees = 0;
  dynamic tenantInfo;


  _StaffTenantDetailsThreeState(user,staff,tenantReference,tenantName){
    this.user = user;
    this.staff = staff;
    this.tenantReference = tenantReference;
    this.tenantName = tenantName;
  }

  getTenantInfo() async{
    await tenantReference.get().then<dynamic>((DocumentSnapshot snapshot){
      setState(() {
        tenantInfo = snapshot.data();
      });

    });

    QuerySnapshot snapshot = await tenantReference.collection('employees').get();
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
    if (tenantInfo == null){return Center(child:CircularProgressIndicator());}

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Tenant Details for $tenantName'),
        ),
      body:
      Align(
        alignment: Alignment.center,
        child:
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Tenant Details for $tenantName: "),
              ],
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Shop Name: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${tenantInfo['shopName']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Institution: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${staff['institution']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Contract Expiry: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${tenantInfo['contractExpiry']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Date Joined: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${tenantInfo['dateJoined']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Unit Number: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${tenantInfo['unitNumber']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Phone Number: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("${tenantInfo['phoneNumber']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
            SizedBox(height:10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text("Number of employees registered: "),
                  Container(
                    alignment: Alignment.center,
                    width: 1000,
                    child: Text("$numEmployees",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]
            ),
          ],
        ),
      )

    );
  }



}
