import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/staffTenantDetailsThree.dart';
import 'package:singhealth_app/classes/institution.dart';

class StaffInstitutionDetails extends StatefulWidget {

  final User user;
  final dynamic staff;


  StaffInstitutionDetails({
    Key key,
    this.user,
    this.staff}) : super(key: key);

  @override
  _StaffInsitutionDetailsState createState() => _StaffInsitutionDetailsState(user,staff);
}

class _StaffInsitutionDetailsState extends State<StaffInstitutionDetails> {

  User user;
  dynamic staff;

  List<dynamic> NonFnBTenantList,FnBTenantList;
  List<String> FullTenantList = [];
  List<String> NonFnBTenantListString, FnBTenantListString;

  _StaffInsitutionDetailsState(user,staff){
    this.user = user;
    this.staff = staff;
  }

  void getTenantsList() async {
    try{
      await FirebaseFirestore.instance.collection('institution').doc(staff['institution']).get().then<dynamic>(( DocumentSnapshot snapshot) async{
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
            NonFnBTenantListString = Institution.convertToStringList(NonFnBTenantList);
            FnBTenantListString = Institution.convertToStringList(FnBTenantList);
          }
          else{
            FullTenantList = [];
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
    if(FnBTenantListString == null || NonFnBTenantListString == null) {return Center(child: CircularProgressIndicator());}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Institution Details for ${staff['institution']}'),
      ),
      body:
          Column(
            children: <Widget>[
              Text("FnB Tenant List",textAlign: TextAlign.left),
              Expanded(child:
                ListView.builder(
                    itemCount: FnBTenantListString.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          title: Text('${FnBTenantListString[index]}'),
                          onTap: (){
                            DocumentReference tenantReference = FirebaseFirestore.instance.collection("institution").doc("${staff['institution']}").collection("tenant").doc(FnBTenantListString[index]);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffTenantDetailsThree(user:user,staff:staff,tenantReference:tenantReference,tenantName:FnBTenantListString[index])));
                          },
                      );
                    }
                ),
              ),
              SizedBox(height:10),
              Text("Non FnB Tenant List", textAlign: TextAlign.left),
              Expanded(child:
                ListView.builder(
                    itemCount: NonFnBTenantListString.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          title: Text('${NonFnBTenantListString[index]}'),
                          onTap: (){
                            DocumentReference tenantReference = FirebaseFirestore.instance.collection("institution").doc("${staff['institution']}").collection("tenant").doc(FnBTenantListString[index]);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffTenantDetailsThree(user:user,staff:staff,tenantReference:tenantReference,tenantName:FnBTenantListString[index])));
                          },
                      );
                    }
                ),
              )
            ],
          )
    );
  }
}
