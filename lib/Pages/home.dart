import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/firebase.dart';

class Home extends StatelessWidget{
  //constructor
  Home({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${user.email}'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestoreInstance.collection("users").doc(user.uid).snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState){
            case ConnectionState.waiting: return Text("loading ...");
            default:
              return Text("Welcome ${snapshot.data['name']} you are logged in as ${snapshot.data['role']}");
          }
        },
      ),
    );
  }

}
