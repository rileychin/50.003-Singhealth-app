import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/classes/tenant.dart';
import 'package:singhealth_app/custom_icons_icons.dart';


class TenantViewPhoto extends StatefulWidget {
  @override
  TenantViewPhoto({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  _TenantViewPhotoState createState() => _TenantViewPhotoState(user,firestoreInstance);
}

class _TenantViewPhotoState extends State<TenantViewPhoto> {
  User user;
  FirebaseFirestore firestoreInstance;

  dynamic data;

  _TenantViewPhotoState(user, firestoreInstance){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }

  Future<dynamic> tenantInformation() async {

    final DocumentReference document =   firestoreInstance.collection("tenant").doc(user.uid);
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data = snapshot.data();
      });
    });
  }

  @override
  void initState(){
    super.initState();
    tenantInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${data["name"]}, you are logged in as tenant'),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(50),
                child: Image.network('https://picsum.photos/250?image=3'),
              )
            ]
        ),
      ),
    );
  }
}
