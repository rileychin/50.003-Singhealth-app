import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/staff.dart';
import 'package:singhealth_app/classes/tenant.dart';

class FirebaseFunctions{

  FirebaseFunctions();

  static Future<User> createUser(email,password) async{
    UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return user;
  }

  static void createStaffWithEmailPassword(String email, String password,Staff newStaff){

    FirebaseFirestore.instance.collection("staff").doc(newStaff.id).set({
      "name" : newStaff.name,
      "email" : newStaff.email,
      "id" : newStaff.id,
      "institution" : newStaff.institution,
    });

    //add to general users in database, to check for role easily
    FirebaseFirestore.instance.collection("users").doc(newStaff.id).set({
      "id" : newStaff.id,
      "role" : "staff",
    });

    //add new staff to institution
    FirebaseFirestore.instance.collection("institution").doc(newStaff.institution).collection("staff").doc(newStaff.id).set({
      "id": newStaff.id,
    });

  }


  static void createTenantWithEmailPassword(String email, String password,Tenant newTenant){

    FirebaseFirestore.instance.collection("tenant").doc(newTenant.id).set({
    "name" : newTenant.name,
    "email" : newTenant.email,
    "id" : newTenant.id,
    "position" : newTenant.position,
    "institution" : newTenant.institution,
    "shopName" : newTenant.shopName,
    });

    //add to general users in database, to check for role easily
    FirebaseFirestore.instance.collection("users").doc(newTenant.id).set({
      "id" : newTenant.id,
      "role" : "tenant",
    });

    //now add new tenant to institution
    //institution -> institution name -> tenant -> shop name -> employees -> id -> information
    FirebaseFirestore.instance.collection("institution").doc(newTenant.institution).collection("tenant").doc(newTenant.shopName)
        .collection("employees").doc(newTenant.id).set({
      "id": newTenant.id,
      "position" : newTenant.position,
    });

    //document not showing up in firebase, need to enter empty value
    FirebaseFirestore.instance.collection("institution").doc(newTenant.institution).set({
      "institution": newTenant.institution,
    });
    FirebaseFirestore.instance.collection("institution").doc(newTenant.institution).collection("tenant").doc(newTenant.shopName).set(
      {
        "shopName":newTenant.shopName,
      }
    );


    //TODO: decide who settles the contract expiry date for the tenant shops
    // FirebaseFirestore.instance.collection("institution").doc(newTenant.institution).collection("tenant").doc(newTenant.shopName)
    //     .collection("contract expiry date").doc("contract expiry date").set({
    //   "id": newTenant.id,
    //   "position" : newTenant.position,
    // });

  }

  //getting staff information
  Future<DocumentSnapshot> staffInformation(User user) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("staff").doc(user.uid).get();
    return snapshot;
  }

}
