import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/tenantAuditChecklistFnBTwo.dart';


class TenantAuditChecklistFnB extends StatefulWidget {
  final User user;
  final dynamic tenant;
  final firestoreInstance = FirebaseFirestore.instance;

  TenantAuditChecklistFnB({
    Key key,
    this.user,
    this.tenant}) : super(key: key);

  @override
  _TenantAuditChecklistFnBState createState() => _TenantAuditChecklistFnBState(user, tenant);
}

class _TenantAuditChecklistFnBState extends State<TenantAuditChecklistFnB> {
  User user;
  dynamic tenant;
  final firestoreInstance = FirebaseFirestore.instance;

  _TenantAuditChecklistFnBState(user, tenant){
    this.user = user;
    this.tenant = tenant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${tenant['shopName']} audits list'),
        ),
        body: StreamBuilder(
          stream:
          firestoreInstance.collection('institution').doc(tenant['institution']).collection('tenant').doc(tenant['shopName']).collection('auditChecklist').snapshots(),
          builder: buildUserList,
        )
    );
  }

  @override
  Widget buildUserList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData){
      return ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context,index){
          DocumentSnapshot checklistSnapshot = snapshot.data.docs[index];

          return ListTile(

            selectedTileColor: Colors.amber,
            onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> TenantAuditChecklistFnBTwo(user:user,tenant:tenant,auditChecklist:checklistSnapshot.data())));},
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
