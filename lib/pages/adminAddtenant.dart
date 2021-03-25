import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';
import 'package:toast/toast.dart';

import '../custom_icons.dart';

class AdminAddTenant extends StatefulWidget {


  final User user;
  final dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  AdminAddTenant({
    Key key,
    this.user,
    this.admin}) : super(key: key);

  @override
  _AdminAddTenantState createState() => _AdminAddTenantState(user,admin);
}

class _AdminAddTenantState extends State<AdminAddTenant> {

  User user;
  dynamic admin,auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;

  _AdminAddTenantState(user,admin){
    this.user = user;
    this.admin = admin;
  }


  //fields needed for adding admin
  List<String> _institutions = ['CGH','KKH','SGH','SKH','NCCS','NHCS','BVH','OCH','Academia'];
  String _institution = 'CGH';
  String newTenant,unitNumber,phoneNumber;
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFnB = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Adding tenant for institution ${admin['institution']}'),
      ),

      body:
        Align(
          alignment: Alignment.center,
          child:
              Form(
                key: _formKey,
                child:
                Column(
                  children: <Widget>[
                    Text("Institution : ${admin['institution']}"),
                    LabeledCheckbox(
                        label: ("Food and Beverage tenant?"),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        value: isFnB,
                        onChanged: (bool newValue){
                          setState(() {
                            isFnB = newValue;
                          });
                        }
                    ),
                    TextFormField(
                      validator:(input){
                        if (input.length == 0){
                          return 'Please enter a name for the new tenant';
                        }
                      },
                      onSaved: (input) => newTenant = input,
                      decoration: InputDecoration(
                          labelText: 'Enter new tenant name'
                      ),
                    ),
                    TextFormField(
                      validator:(input){
                        if (input.length == 0){
                          return 'Please enter a unit number';
                        }
                      },
                      onSaved: (input) => unitNumber = input,
                      decoration: InputDecoration(
                          labelText: 'Enter tenant unit number'
                      ),
                    ),
                    TextFormField(
                      validator:(input){
                        if (input.length == 0){
                          return 'Please enter a phone number';
                        }
                      },
                      onSaved: (input) => phoneNumber = input,
                      decoration: InputDecoration(
                          labelText: 'Enter tenant phone  number'
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){_selectDate(context);},
                        child:Text("Select contract expiry date")
                    ),
                    Text("${selectedDate.toLocal()}".split(' ')[0]),

                    RaisedButton.icon(
                      icon: Icon(CustomIcons.check),
                      label: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue[300],
                      onPressed: createNewTenant,
                    ),
                  ],
                )
              )

        )

    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  void createNewTenant() async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
    }
    try{

      DocumentReference institutionRef = firestoreInstance.collection("institution").doc(admin['institution']);
      List<dynamic> tenantList = [];

      //If it already exists then update
      try {
        DocumentSnapshot snapshot = await institutionRef.get();

        if (isFnB){
          //START
          tenantList = snapshot['FnBTenantList'];
          if (checkExists(tenantList)){
            Toast.show("tenant already exists", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }
          else{
            tenantList.add(newTenant);
            institutionRef.update({
              'FnBTenantList' : tenantList
            });
            tenantList.clear();
            Toast.show("Successfully added new tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            institutionRef.collection('tenant').doc(newTenant).set({
              'contractExpiry' : selectedDate.toLocal().toString().split(' ')[0], //add contract expiry date to list
              'shopName' : newTenant,
              'dateJoined' : DateTime.now().toLocal().toString().split(' ')[0],
              'unitNumber' : unitNumber,
              'phoneNumber' : phoneNumber,
            });
          }
          //END
        }
        else{
          tenantList = snapshot['NonFnBTenantList'];
          if (checkExists(tenantList)){
            Toast.show("tenant already exists", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }
          else{
            tenantList.add(newTenant);
            institutionRef.update({
              'NonFnBTenantList' : tenantList
            });

            Toast.show("Successfully added new tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            tenantList.clear();
            institutionRef.collection('tenant').doc(newTenant).set({
              'contractExpiry' : selectedDate.toLocal().toString().split(' ')[0], //add contract expiry date to list
              'shopName' : newTenant,
              'dateJoined' : DateTime.now().toLocal().toString().split(' ')[0],
              'unitNumber' : unitNumber,
              'phoneNumber' : phoneNumber,
            });
          }
        }
      }catch(e){
        //else it does not exist so create new one
        if (isFnB){
          tenantList.add(newTenant);
          institutionRef.set({
            'FnBTenantList' : tenantList
          });
          tenantList.clear();
          Toast.show("Successfully added new tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }
        else{
          tenantList.add(newTenant);
          institutionRef.set({
            'NonFnBTenantList' : tenantList
          });
          tenantList.clear();
          Toast.show("Successfully added new tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }

        institutionRef.collection('tenant').doc(newTenant).set({
          'contractExpiry' : selectedDate.toLocal().toString().split(' ')[0], //add contract expiry date to list
          'shopName' : newTenant,
          'dateJoined' : DateTime.now().toLocal().toString().split(' ')[0],
          'unitNumber' : unitNumber,
          'phoneNumber' : phoneNumber,
        });
      }


    }catch(e){
      print(e);
    }
  }

  bool checkExists(List tenantList) {
    for (int i = 0; i < tenantList.length; i++){
      if (tenantList[i] == newTenant){
        return true;
      }
    }
    return false;
  }


}
