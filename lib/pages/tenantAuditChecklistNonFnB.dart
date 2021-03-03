import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/tenantAuditChecklistNonFnBTwo.dart';

class TenantAuditChecklistNonFnB extends StatefulWidget {

  final User user;
  final dynamic tenant;
  final firestoreInstance = FirebaseFirestore.instance;

  TenantAuditChecklistNonFnB({
    Key key,
    this.user,
    this.tenant}) : super(key: key);

  @override
  _TenantAuditChecklistNonFnBState createState() => _TenantAuditChecklistNonFnBState(user,tenant);
}

class _TenantAuditChecklistNonFnBState extends State<TenantAuditChecklistNonFnB> {

  User user;
  dynamic tenant;
  final firestoreInstance = FirebaseFirestore.instance;

  _TenantAuditChecklistNonFnBState(user,tenant){
    this.user = user;
    this.tenant = tenant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('${tenant['shopName']} audits list'),
        ),
        body: StreamBuilder(
          stream:
          firestoreInstance.collection('institution').doc(tenant['institution']).collection('tenant').doc(tenant['shopName']).collection('auditChecklist').snapshots(),
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
            onTap: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> TenantAuditChecklistNonFnBTwo(user:user,tenant:tenant,auditChecklist:checklistSnapshot.data())));},
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
