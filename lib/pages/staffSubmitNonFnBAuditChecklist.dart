import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffSubmitNonFnBAuditChecklist extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffSubmitNonFnBAuditChecklist({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference}) : super(key: key);

  @override
  _StaffSubmitNonFnBAuditChecklistState createState() => _StaffSubmitNonFnBAuditChecklistState(user,staff,tenantName,tenantReference);
}

class _StaffSubmitNonFnBAuditChecklistState extends State<StaffSubmitNonFnBAuditChecklist> {


  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  _StaffSubmitNonFnBAuditChecklistState(user,staff,tenantName,tenantReference){
    this.user = user;
    this.staff = staff;
    this.tenantName = tenantName;
    this.tenantReference = tenantReference;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Submit Non FnB Audit Checklist'),
      ),
    );
  }
}