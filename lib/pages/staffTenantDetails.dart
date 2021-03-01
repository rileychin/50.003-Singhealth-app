import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/staffTenantDetailsTwo.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/classes/staff.dart';
import 'dart:html';
import 'package:toast/toast.dart';

class StaffTenantDetails extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  StaffTenantDetails({
    Key key,
    this.user,
    this.staff}) : super(key: key);




  @override
  _StaffTenantDetailsState createState() => _StaffTenantDetailsState(user,firestoreInstance,staff);

}

class _StaffTenantDetailsState extends State<StaffTenantDetails> {

  User user;
  FirebaseFirestore firestoreInstance;
  dynamic staff;

  String tenantName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _StaffTenantDetailsState(user,firestoreInstance,staff){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
    this.staff = staff;
  }


  @override
  Widget build(BuildContext context) {
    if (staff == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Tenant Details'),
      ),

      body: Form(
        key: _formKey,
        child:
          Align(
            alignment: Alignment.center,
            child:
              Column(
                children: <Widget>[
                  Text("${staff['institution']}"),
                  DropdownButton(
                    hint: Text('Select tenant'),
                    value: tenantName,
                    onChanged: (newValue) {
                      setState(() {
                        tenantName = newValue;
                      });
                    },
                    items: Institution.fullTenantList(staff['institution']).map((shopName) {
                      return DropdownMenuItem(
                        child: new Text(shopName),
                        value: shopName,
                      );
                    }).toList(),
                  ),
                  ElevatedButton(onPressed: navigateToTenantDetailsTwo, child: Text("Find"))
                ],
              )
          )
      ),

    );
  }

  void navigateToTenantDetailsTwo() {
    if (tenantName == null){
      Toast.show("Please choose a tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
    else{
      DocumentReference tenantReference = firestoreInstance.collection("institution").doc("${staff['institution']}").collection("tenant").doc(tenantName);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffTenantDetailsTwo(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName)));
    }
  }
}