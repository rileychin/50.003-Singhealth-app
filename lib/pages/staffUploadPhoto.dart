import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';
import 'package:toast/toast.dart';

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
  Uint8List data;
  User user;
  FirebaseFirestore firestoreInstance;
  String _institution;
  //used for data snapshots
  dynamic staffData,institutionData;
  DocumentSnapshot staffSnapshot;
  Image image;


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
                //todo: add validator for dropdown button
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
              Container(child:image != null ? image : Text('No photo uploaded')),
              ElevatedButton(onPressed: uploadPhoto,
                child: Text('Upload Photo'),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: addIncident,
                child: Text('Confirm'),
              )
            ],
          )
        ),

      )
    );
  }

  //TODO: add upload photo function
  Future<void> uploadPhoto() async {
    FilePickerResult picked = await FilePicker.platform.pickFiles();
    this.data = picked.files.single.bytes;
    setState(() {
      this.image = Image.memory(this.data,width: 400,height: 400,);
    });
  }

  //TODO: navigate to confirmation page
  Future<void> addIncident() async {
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      CollectionReference incidentCollectionRef = FirebaseFirestore.instance.collection("institution").doc(staffData['institution']).collection("tenant").doc(tenantName)
          .collection("nonComplianceReport");
      while(true) {
        DocumentSnapshot docSnap = await incidentCollectionRef.doc(incidentName).get();
        if (docSnap.exists) {
          incidentName += ' 2';
        } else {
          break;
        }
        //todo: add max size check
      }

      if (incidentName != null && location != null && summary != null && data != null) {
        FirebaseFirestore.instance.collection("institution").doc(
            staffData['institution']).collection("tenant").doc(tenantName)
            .collection("nonComplianceReport").doc(incidentName).set({
          "incidentName": incidentName,
          "location": location,
          "summary": summary,
          "status": "incomplete",
          "data": data
        });
      }
      else{
        Toast.show("Empty fields", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
    //confirmation and navigation
    Toast.show("Photo uploaded", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
