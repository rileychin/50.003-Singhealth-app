import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/adminAddTenant.dart';
import 'package:singhealth_app/Pages/adminDeleteTenant.dart';

class AdminAddDeleteTenant extends StatefulWidget {
  final User user;
  final dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  AdminAddDeleteTenant({Key key, this.user, this.admin}) : super(key: key);

  @override
  _AdminAddDeleteTenantState createState() =>
      _AdminAddDeleteTenantState(user, admin);
}

class _AdminAddDeleteTenantState extends State<AdminAddDeleteTenant> {
  //TODO: add 2 buttons, one for delete one for add
  User user;
  dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  _AdminAddDeleteTenantState(user, admin) {
    this.user = user;
    this.admin = admin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Add or Delete a tenant'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Positioned(
                  left: 150,
                  top: 1,
                  child: Image(
                    width: 200,
                    height: 200,
                    image: AssetImage('images/SingHealth_Logo.png'),
                  ),
                ),
                Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: navigateToAdminAddTenant,
                            child: Text("Add a new tenant"),
                          ),
                        ),
                      ),
                ),
                Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: navigateToAdminDeleteTenant,
                          child: Text("Delete an existing tenant"),
                        ),
                      ),

                    ),


                ),


              ],
            ),
          ),
        ));
  }

  void navigateToAdminAddTenant() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminAddTenant(user: user, admin: admin)));
  }

  void navigateToAdminDeleteTenant() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminDeleteTenant(user: user, admin: admin)));
  }
}
