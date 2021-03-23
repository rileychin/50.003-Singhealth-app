import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/staffAuditDetailsNonFnBTwo.dart';

class StaffAuditDetailsNonFnB extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffAuditDetailsNonFnB({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference}) : super(key: key);

  @override
  _StaffAuditDetailsNonFnBState createState() => _StaffAuditDetailsNonFnBState(user,staff,tenantName,tenantReference);
}

class _StaffAuditDetailsNonFnBState extends State<StaffAuditDetailsNonFnB> {


  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  _StaffAuditDetailsNonFnBState(user,staff,tenantName,tenantReference){
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
          title: Text('$tenantName audits list'),
        ),
        body: StreamBuilder(
          stream:
          firestoreInstance.collection('institution').doc(staff['institution']).collection('tenant').doc(tenantName)
              .collection('auditChecklist').snapshots(),
          builder: buildUserList,
        )
    );
  }

  Widget buildUserList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData){
      return ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context,index){
          DocumentSnapshot checklistSnapshot = snapshot.data.docs[index];

          return ListTile(

            selectedTileColor: Colors.amber,
            onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> StaffAuditDetailsNonFnBTwo(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName,auditChecklist:checklistSnapshot.data())));},
            title: Text(checklistSnapshot.data()['date']),
            subtitle: Text(checklistSnapshot.data()['auditor']),
          );
        },
      );
    }
    else if ((snapshot.connectionState == ConnectionState.done && snapshot.data.docs.length == 0) || !snapshot.hasData){
      return ListTile(
        title: Text("No audit checklist for this tenant available"),
      );
    }
    else{
      return CircularProgressIndicator();
    }

  }

}
