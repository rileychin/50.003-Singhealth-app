import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/admin.dart';
import 'package:singhealth_app/classes/staff.dart';
import 'package:singhealth_app/classes/tenant.dart';

class FirebaseFunctions{

  FirebaseFunctions();

  static Future<User> createUser(email,password) async{
    UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return user;
  }



  static void createAdminWithEmailPassword(String email, String password,Admin newAdmin){

    FirebaseFirestore.instance.collection("admin").doc(newAdmin.id).set({
      "name" : newAdmin.name,
      "email" : newAdmin.email,
      "id" : newAdmin.id,
      "institution" : newAdmin.institution,
    });

    //add to general users in database, to check for role easily
    FirebaseFirestore.instance.collection("users").doc(newAdmin.id).set({
      "id" : newAdmin.id,
      "role" : "admin",
    });

    //add new staff to institution
    FirebaseFirestore.instance.collection("institution").doc(newAdmin.institution).collection("admin").doc(newAdmin.id).set({
      "id": newAdmin.id,
    });

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



  }

  //getting staff information
  Future<DocumentSnapshot> staffInformation(User user) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("staff").doc(user.uid).get();
    return snapshot;
  }

  static Future<List<dynamic>> getInstitutionNonFnBTenants(String institution) async{
    DocumentSnapshot snapshot2 = await FirebaseFirestore.instance.collection("institution").doc(institution).get();
    try{
      List<dynamic> tenantList = snapshot2['NonFnBTenantList'];
      return tenantList;
    }catch(e){
      return [];
    }
  }

  static Future<List<dynamic>> getInstitutionFnBTenants(String institution) async{
    DocumentSnapshot snapshot1 = await FirebaseFirestore.instance.collection("institution").doc(institution).get();
    try{
      List<dynamic> tenantList = snapshot1['FnBTenantList'];
      return tenantList;
    }catch(e){
      return [];
    }
  }


}
