import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/StaffAuditDetailsFnB.dart';
import 'package:singhealth_app/Pages/StaffAuditDetailsNonFnB.dart';
import 'package:singhealth_app/Pages/staffSubmitFnBAuditChecklist.dart';
import 'package:singhealth_app/Pages/staffSubmitNonFnBAuditChecklist.dart';

class StaffTenantDetailsTwo extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffTenantDetailsTwo({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference}) : super(key: key);


  @override
  _StaffTenantDetailsTwoState createState() => _StaffTenantDetailsTwoState(user,staff,tenantName,tenantReference);
}

class _StaffTenantDetailsTwoState extends State<StaffTenantDetailsTwo> {

  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  List<String> nonFnBList = ['168 Florist','Eu Yan Sang',
    'Hua Xia Taimobi Centre',
    'Mothercare',
    'The Choice Gift House',
    'B&G LifeCasting',
    'Junior Page',
    'Neol Gifts',
    'Spextacular Optics',
    'Lifeforce Limbs',
    'Noel',
    'Lifeline',
    'Noel Gifts',
    'Anytime Fitness',
    'Kindermusk',
  ];

  _StaffTenantDetailsTwoState(user,staff,tenantName,tenantReference){
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
        title: Text('Tenant Details(continued)'),
      ),
      body:
        Align(
          alignment: Alignment.center,
          child:
            Column(
              children:<Widget>[
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: navigateToSubmitAuditChecklist,
                  child: Text("Submit Audit Checklist"),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: navigateToAuditDetails,
                  child: Text("Audit Details"),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){},
                  child: Text("Tenant Details"),
                ),
              ]
            )
        )
    );
  }

  void navigateToSubmitAuditChecklist() {

    //to allow for navigation to different types of audit checklist

    if (nonFnBList.contains(tenantName)){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffSubmitNonFnBAuditChecklist(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName)));
    }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffSubmitFnBAuditChecklist(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName)));
    }


  }

  void navigateToAuditDetails() {

    if (nonFnBList.contains(tenantName)){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffAuditDetailsNonFnB(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName)));
    }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffAuditDetailsFnB(user:user,staff:staff,tenantReference:tenantReference,tenantName:tenantName)));
    }

  }
}
