import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/Pages/staffHome.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';
import 'package:toast/toast.dart';

class StaffUploadPhoto extends StatefulWidget {
  @override
  StaffUploadPhoto({Key key, this.user, this.staff}) : super(key: key);

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  _StaffUploadPhotoState createState() =>
      _StaffUploadPhotoState(user, firestoreInstance, staff);
}

class _StaffUploadPhotoState extends State<StaffUploadPhoto> {
  String tenantName, location, incidentName, summary, additionalNotes;
  Uint8List data;
  User user;
  FirebaseFirestore firestoreInstance;
  String _institution;
  //used for data snapshots
  dynamic staff, staffData, institutionData;
  DocumentSnapshot staffSnapshot;
  Image image;

  List<dynamic> NonFnBTenantList, FnBTenantList;
  List<String> FullTenantList;
  List<String> _shopNameList = [];
  String _shopName;

  //global form key used to validate forms
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _StaffUploadPhotoState(user, firestoreInstance, staff) {
    this.user = user;
    this.firestoreInstance = firestoreInstance;
    this.staff = staff;
  }

  //getting staff information from snapshot
  Future<dynamic> staffInformation() async {
    final DocumentReference document =
        firestoreInstance.collection("staff").doc(user.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        staffData = snapshot.data();
        _institution = staffData['institution'];
      });
    });
  }

  void getTenantsList() async {
    try {
      await FirebaseFirestore.instance
          .collection('institution')
          .doc(staff['institution'])
          .get()
          .then<dynamic>((DocumentSnapshot snapshot) async {
        setState(() {
          if (snapshot.exists) {
            if (snapshot.data().containsKey('NonFnBTenantList')) {
              NonFnBTenantList = snapshot.data()['NonFnBTenantList'];
            } else {
              NonFnBTenantList = [];
            }
            if (snapshot.data().containsKey('FnBTenantList')) {
              FnBTenantList = snapshot.data()['FnBTenantList'];
            } else {
              FnBTenantList = [];
            }
            FullTenantList = Institution.convertToStringList(
                NonFnBTenantList + FnBTenantList);
            _shopNameList = FullTenantList;
            _shopName = _shopNameList[0];
          } else {
            FullTenantList = [];
            _shopNameList = FullTenantList;
            _shopName = null;
          }
        });
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    staffInformation();
    getTenantsList();
  }

  @override
  Widget build(BuildContext context) {
    if (staffData == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Upload non-compliance incident photo'),
        ),
        body: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(400.0, 30.0, 400.0, 200.0),
                    child: Card(
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "${staffData['institution']}",
                                ),
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
                                items: _shopNameList.map((shopName) {
                                  return DropdownMenuItem(
                                    child: new Text(shopName),
                                    value: shopName,
                                  );
                                }).toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Please enter the location';
                                    }
                                  },
                                  onSaved: (input) => location = input,
                                  decoration: InputDecoration(
                                      labelText: 'Location of incident'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Please enter the incident title';
                                    }
                                  },
                                  onSaved: (input) => incidentName = input,
                                  decoration: InputDecoration(
                                      labelText: 'Incident Title'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Please enter a short summary of the incident';
                                    }
                                  },
                                  onSaved: (input) => summary = input,
                                  decoration:
                                      InputDecoration(labelText: 'Summary'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    child: image != null
                                        ? image
                                        : Text('No photo uploaded')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: ElevatedButton(
                                      onPressed: uploadPhoto,
                                      child: Text('Upload Photo'),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: RaisedButton.icon(
                                    icon: Icon(CustomIcons.check),
                                    label: Text("Confirm"),
                                    textColor: Colors.white,
                                    color: Colors.blue[300],
                                    onPressed: addIncident,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(30),
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
                      ),
                    ),
                  ),
                );
              },
            )));
  }

  Future<void> uploadPhoto() async {
    FilePickerResult picked = await FilePicker.platform.pickFiles();
    this.data = picked.files.single.bytes;

    setState(() {
      this.image = Image.memory(this.data, width: 400, height: 400);
    });
  }

  //TODO: navigate to confirmation page
  Future<void> addIncident() async {
    if (this.data == null) {
      Toast.show("No incident image selected.", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        CollectionReference incidentCollectionRef = FirebaseFirestore.instance
            .collection("institution")
            .doc(staffData['institution'])
            .collection("tenant")
            .doc(tenantName)
            .collection("nonComplianceReport");
        while (true) {
          DocumentSnapshot docSnap =
              await incidentCollectionRef.doc(incidentName).get();
          if (docSnap.exists) {
            incidentName += ' 2';
          } else {
            break;
          }
          //todo: add max size check
        }

        if (incidentName != null &&
            location != null &&
            summary != null &&
            data != null) {
          FirebaseFirestore.instance
              .collection("institution")
              .doc(staffData['institution'])
              .collection("tenant")
              .doc(tenantName)
              .collection("nonComplianceReport")
              .doc(incidentName)
              .set({
            "incidentName": incidentName,
            "location": location,
            "summary": summary,
            "status": "unresolved"
          });

          FirebaseFirestore.instance
              .collection('institution')
              .doc(staffData['institution'])
              .collection('tenant')
              .doc(tenantName)
              .collection('nonComplianceReport')
              .doc(incidentName)
              .collection('images')
              .doc('incident_image')
              .set({"data": data});
        } else {
          Toast.show("Empty fields", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }
      //confirmation and navigation
      Toast.show("Photo uploaded", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      back();
    }
  }

  void back() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => StaffHome(user: user)));
  }
}
