import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';

class StaffUploadPhoto extends StatefulWidget {

  @override
  StaffUploadPhoto({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  _StaffUploadPhotoState createState() => _StaffUploadPhotoState(user,firestoreInstance);
}

class _StaffUploadPhotoState extends State<StaffUploadPhoto> {

  String tenantName,location,incidentName,summary,additionalNotes;

  User user;
  FirebaseFirestore firestoreInstance;
  String _institution;
  //used for data snapshots
  dynamic staffData,institutionData;
  DocumentSnapshot staffSnapshot;


  //global form key used to validate forms
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _StaffUploadPhotoState(user,firestoreInstance){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }

  //getting staff information from snapshot
  Future<dynamic> staffInformation() async{
    final DocumentReference document = firestoreInstance.collection("staff").doc(user.uid);
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        staffData =snapshot.data();
        _institution = staffData['institution'];

      });
    });
  }

  @override
  void initState(){
    super.initState();
    // staffInformation();
    staffInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (staffData == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Upload Non compliance incident photo'),
      ),
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child:
          Column(
            children: <Widget>[
              Text("${staffData['institution']}",
              ),
              DropdownButton(
                hint: Text('Select tenant'),
                value: tenantName,
                onChanged: (newValue) {
                  setState(() {
                    tenantName = newValue;
                  });
                },
                items: Institution.fullTenantList(staffData['institution']).map((shopName) {
                  return DropdownMenuItem(
                    child: new Text(shopName),
                    value: shopName,
                  );
                }).toList(),
              ),
              TextFormField(
                validator:(input){
                  if (input.isEmpty){
                    return 'Please enter the location';
                  }
                },
                onSaved: (input) => location = input,
                decoration: InputDecoration(
                    labelText: 'Location of incident'
                ),
              ),
              TextFormField(
                validator:(input){
                  if (input.isEmpty){
                    return 'Please enter the incident title';
                  }
                },
                onSaved: (input) =>  incidentName = input,
                decoration: InputDecoration(
                    labelText: 'Incident Title'
                ),
              ),
              TextFormField(
                validator:(input){
                  if (input.isEmpty){
                    return 'Please enter a short summary of the incident';
                  }
                },
                onSaved: (input) => summary = input,
                decoration: InputDecoration(
                    labelText: 'Summary'
                ),
              ),
              ElevatedButton(onPressed: uploadPhoto,
                child: Text('Upload Photo'),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: addIncident,
                child: Text('Sign Up'),
              )
            ],
          )
        ),

      )
    );
  }

  //TODO: add upload photo function
  void uploadPhoto() {
  }

  //TODO: navigate to confirmation page
  void addIncident() {
    print(staffData['institution']);
    print(tenantName);
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();


      FirebaseFirestore.instance.collection("institution").doc(staffData['institution']).collection("tenant").doc(tenantName)
          .collection("nonComplianceReport").doc(incidentName).set({
        "incidentName" : incidentName,
        "location" : location,
        "summary" : summary,
        "status" : "incomplete",
      });

    }
  }
}
