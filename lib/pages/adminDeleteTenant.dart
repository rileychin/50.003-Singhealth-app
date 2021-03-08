import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminDeleteTenant extends StatefulWidget {

  final User user;
  final dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  AdminDeleteTenant({
    Key key,
    this.user,
    this.admin}) : super(key: key);
  @override
  _AdminDeleteTenantState createState() => _AdminDeleteTenantState(user,admin);
}

class _AdminDeleteTenantState extends State<AdminDeleteTenant> {

  User user;
  dynamic admin,auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;

  _AdminDeleteTenantState(user,admin){
    this.user = user;
    this.admin = admin;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Deleting tenant for institution ${admin['institution']}'),
      ),
      body:
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[

            ],
          ),
        )

    );
  }
}
