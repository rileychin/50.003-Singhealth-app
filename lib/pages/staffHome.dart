import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/Pages/staffAccount.dart';
import 'package:singhealth_app/Pages/staffInstitutionDetails.dart';
import 'package:singhealth_app/Pages/staffTenantDetails.dart';
import 'package:singhealth_app/Pages/staffUploadPhoto.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';


class StaffHome extends StatefulWidget {
  @override
  StaffHome({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;


  _StaffHomeState createState() => _StaffHomeState(user,firestoreInstance);
}

class _StaffHomeState extends State<StaffHome> {

  User user;
  FirebaseFirestore firestoreInstance;
  Image image;
  Uint8List imageData;
  dynamic data;

  _StaffHomeState(user, firestoreInstance){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }


  Future<dynamic> staffInformation() async {

    final DocumentReference document = firestoreInstance.collection("staff").doc(user.uid);
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async {
      setState(() {
        data =snapshot.data();
      });
    });

    await firestoreInstance.collection('staff').doc(user.uid).collection('profile_picture').doc('0').get().then((value) async {
      setState(() {
        imageData = new Uint8List.fromList(value.data()['data'].cast<int>());
        image = Image.memory(imageData, width: 400, height: 400);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    staffInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Welcome ${data["name"]}, you are logged in as staff'),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 500),
                  padding: EdgeInsets.all(25),
                  color: Colors.green[100],
                  child: Row(
                    children: <Widget> [
                      Column(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Name: ${data["name"]}"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Branch Location: ${data["institution"]}"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Staff Number: ${data["id"]}"),
                          ),
                        ],
                      ),

                      InkWell(
                        onTap: () async {
                          FilePickerResult picked = await FilePicker.platform.pickFiles();
                          this.imageData = picked.files.single.bytes;

                          setState(() {
                            this.image = Image.memory(this.imageData, width: 400, height: 400);
                          });

                          if (this.imageData != null) {
                            FirebaseFirestore.instance.collection('staff').doc(user.uid).collection('profile_picture').doc('0').set({
                              'data': imageData
                            });
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                            height: 120,
                            width: 120,
                            child: image != null ? image : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage('images/DefaultUserPic.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  )
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 500),
                  padding: EdgeInsets.all(25),
                  color: Colors.orange[100],
                  child: Row(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 10, 135, 10),
                        child: Text("Account & Institution"),
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.clipboard_user), onPressed: navigateToStaffAccount),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Account"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.clipboard_checklist), onPressed: navigateToStaffTenantDetails),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                            child: Text("Tenant Details"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.document), onPressed: navigateToStaffInstitutionDetails),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Text("Institution Details"),
                          ),
                        ],
                      ),
                    ],
                  )
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 500),
                  padding: EdgeInsets.all(25),
                  color: Colors.red[100],
                  child: Row(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 10, 50, 10),
                        child: Text("Non-compliance Incidents"),
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.calendar_exclamation), onPressed: navigateToStaffUploadPhoto),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Upload Incident"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.history), onPressed: null),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Review Incident Status"),
                          ),
                        ],
                      ),
                    ],
                  )
              ),

              RaisedButton.icon(
                icon: Icon(CustomIcons.sign_out),
                label: Text("Sign Out"),
                textColor: Colors.white,
                color: Colors.blue[300],
                onPressed: signOut,
              ),
            ]
        ),
      ),
    );
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> WelcomePage()));
  }


  void navigateToStaffUploadPhoto() async{
    Navigator.push(context,MaterialPageRoute(builder:(context) => StaffUploadPhoto(user:user,staff:data)));
  }


  void navigateToStaffTenantDetails() {
    Navigator.push(context,MaterialPageRoute(builder:(context) => StaffTenantDetails(user:user,staff:data)));
  }

  void navigateToStaffAccount() {
    Navigator.push(context,MaterialPageRoute(builder:(context)=> StaffAccount(user:user,staff:data)));
  }

  void navigateToStaffInstitutionDetails() {
    Navigator.push(context,MaterialPageRoute(builder:(context)=> StaffInstitutionDetails(user:user,staff:data)));
  }
}

