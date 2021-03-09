import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:toast/toast.dart';

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

  List<dynamic> NonFnBTenantList,FnBTenantList;
  List<String> FullTenantList;
  List<String> _shopNameList = [];
  String _shopName;

   void getTenantsList() async {
     try{

       await FirebaseFirestore.instance.collection('institution').doc(admin['institution']).get().then<dynamic>(( DocumentSnapshot snapshot) async{
         setState(() {
           if (snapshot.exists){
             if (snapshot.data().containsKey('NonFnBTenantList')){
               NonFnBTenantList = snapshot.data()['NonFnBTenantList'];
             }
             else{
               NonFnBTenantList = [];
             }
             if (snapshot.data().containsKey('FnBTenantList')){
               FnBTenantList = snapshot.data()['FnBTenantList'];
             }
             else{
               FnBTenantList = [];
             }
             FullTenantList = Institution.convertToStringList(NonFnBTenantList + FnBTenantList);
             _shopNameList = FullTenantList;
             _shopName = _shopNameList[0];
           }
           else{
             FullTenantList = [];
             _shopNameList = FullTenantList;
             _shopName = null;
           }

         });

       });

     }catch(e){
     }
  }

  @override
  void initState() {

    super.initState();
    getTenantsList();
  }

  @override
  Widget build(BuildContext context) {
    if (FullTenantList == null) return Center(child: CircularProgressIndicator());
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

              //TODO: add button here to remove tenant from Cloud firestore
              DropdownButton(
                hint: Text('Remove a tenant from your institition'),
                value: _shopName,
                onChanged: (newValue) {
                  setState(() {
                    _shopName = newValue;
                  });
                },
                items: _shopNameList.map((shopName) {
                  return DropdownMenuItem(
                    child: new Text(shopName),
                    value: shopName,
                  );
                }).toList(),
              ),
              ElevatedButton(onPressed: deleteTenant, child: Text("Confirm Delete"))
            ],
          ),
        )

    );
  }



  void deleteTenant() async{
     if (_shopName == null){
       Toast.show("Please select a tenant", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
     }
     else{
       DocumentReference institutionRef = firestoreInstance.collection("institution").doc(admin['institution']);
       DocumentSnapshot snapshot = await institutionRef.get();
       List<String> FnBList = Institution.convertToStringList(snapshot.data()['FnBTenantList']);
       List<String> NonFnBList = Institution.convertToStringList(snapshot.data()['NonFnBTenantList']);
       FnBList = removeElement(FnBList,_shopName);
       NonFnBList = removeElement(NonFnBList, _shopName);

       //setting FnB / NonFnB TenantList
       institutionRef.set({
         'FnBTenantList' : FnBList,
         'NonFnBTenantList' : NonFnBList,
       });

       //removing totally from institution collection
       institutionRef.collection('tenant').doc(_shopName).delete();
       Toast.show("Tenant removed successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> AdminHome(user:user)));
     }


  }

  List<String> removeElement(List<String> list,String element){
     List<String> returnList = [];
     for (int i =0 ; i< list.length; i++){
       if (list[i] != element){
         returnList.add(list[i]);
       }
     }
     return returnList;
  }
}
