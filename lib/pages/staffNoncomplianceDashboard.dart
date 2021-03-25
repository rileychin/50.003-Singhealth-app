

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class StaffNonComplianceDashboard extends StatefulWidget {
  @override
  StaffNonComplianceDashboard({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;


  _StaffNonComplianceDashboardState createState() => _StaffNonComplianceDashboardState(user,firestoreInstance);
}

class _StaffNonComplianceDashboardState extends State<StaffNonComplianceDashboard> {

  User user;
  FirebaseFirestore firestoreInstance;
  List<String> tenantList,incidentList;
  QuerySnapshot querySnapshot;
  String institution;
  bool shopSelected = false;

  _StaffNonComplianceDashboardState(user,firestoreinstance) {
    this.user = user;
    this.firestoreInstance = firestoreinstance;
  }

  void initState(){
    super.initState();
    //future
  }

  Future<List<dynamic>> updateNonCompliance() async {
    //TODO: add code to update list
    DocumentReference docRef = firestoreInstance.collection('staff').doc(user.uid);
    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) => {
      institution = snapshot.data()['institution']
    });
    querySnapshot = await firestoreInstance.collection('institution').doc(institution).collection('tenant').get();

    String inc = '';
    querySnapshot.docs.forEach((doc) {
      inc += doc['shopName'] + ':';

    });

    inc = inc.substring(0,inc.length-1);
    tenantList = inc.split(":");
    setState(() {
      tenantList = tenantList;
    });
  }

  Future<void> getIncidents(int index) async {
    String shop = tenantList[index];
    QuerySnapshot querySnapshot = await firestoreInstance.collection('institution').doc(institution).collection('tenant').doc(shop).collection('nonComplianceReport').get();
    String inc = '';
    querySnapshot.docs.forEach((doc){
      inc += doc['incidentName'] + ':';
    });

    inc = inc.substring(0,inc.length-1);
    incidentList = inc.split(":");
    setState(() {
      incidentList = incidentList;
      shopSelected = true;
    });



  }


  @override
  Widget build(BuildContext context) =>
      FutureBuilder(
        future: updateNonCompliance(),
        builder: (context,snapshot){
          if (tenantList == null) {return Center(child: CircularProgressIndicator());}
          else {
            if (shopSelected == false) {
              return Scaffold(
                appBar: AppBar(
                    title: Text("Non Compliance Dashboard")
                ),
                body: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: tenantList.length,

                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          color: Colors.amber[500],
                          child: RawMaterialButton(
                              child: Center(
                                  child: Text(tenantList[index].toString())),
                              onPressed: () {getIncidents(index);}
                          )

                      );
                    }


                ),

              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Non Compliance Report")
                ),
                body: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: incidentList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      height: 50,
                      color: Colors.amber[500],
                      child: Center(
                          child: Text(incidentList[index]))
                    );
                  },

                )
              );
            }
          }


        }
      );


}
