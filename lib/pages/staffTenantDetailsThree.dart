import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffTenantDetailsThree extends StatefulWidget {
  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffTenantDetailsThree(
      {Key key, this.user, this.staff, this.tenantReference, this.tenantName})
      : super(key: key);

  @override
  _StaffTenantDetailsThreeState createState() =>
      _StaffTenantDetailsThreeState(user, staff, tenantReference, tenantName);
}

class _StaffTenantDetailsThreeState extends State<StaffTenantDetailsThree> {
  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  DocumentReference tenantReference;
  String tenantName;
  int numEmployees = 0;
  dynamic tenantInfo;
  dynamic employeeInfo;

  //if the tenant contract is expiring, send email to different positions.
  List<dynamic> allData;
  List<String> allDataString;
  dynamic selectedEmployee;
  String selectedEmployeeID;
  String selectedEmployeePosition;
  List<String> allEmployeeID = [];
  List<String> allEmployeePosition = [];
  List<String> emailList = [];


  _StaffTenantDetailsThreeState(user, staff, tenantReference, tenantName) {
    this.user = user;
    this.staff = staff;
    this.tenantReference = tenantReference;
    this.tenantName = tenantName;
  }

  getTenantInfo() async {
    await tenantReference.get().then<dynamic>((DocumentSnapshot snapshot) {
      setState(() {
        tenantInfo = snapshot.data();
      });
    });
  QuerySnapshot snapshot =
        await tenantReference.collection('employees').get();
    List<DocumentSnapshot> snapshotCount = snapshot.docs;
    setState(() {
      numEmployees = snapshotCount.length;

    });

    // Get data from docs and convert map to List
    allData = snapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0 ; i < allData.length; i++){
      allEmployeeID.add(allData[i]['id']);
      allEmployeePosition.add(allData[i]['position']);
    }

    //search through tenant database and get all the same email documents
    QuerySnapshot snapshot2 = await FirebaseFirestore.instance.collection("tenant").get();

    List<dynamic> tenantList = snapshot2.docs.map((doc) => doc.data()).toList();
    for (int i = 0 ; i< allEmployeeID.length;i++){
      for (int j = 0; j < tenantList.length; j++){
        if (allEmployeeID[i]==tenantList[j]['id']){
          emailList.add(tenantList[j]['email']);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTenantInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (tenantInfo == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Tenant Details for $tenantName'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 500.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          tileColor: Colors.grey,
                          title: Center(
                            child: Text(
                              "Tenant Details for $tenantName: ",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Shop Name: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['shopName']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Institution: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${staff['institution']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Contract Expiry: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['contractExpiry']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Date Joined: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['dateJoined']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Unit Number: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['unitNumber']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Phone Number: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "${tenantInfo['phoneNumber']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Number of employees registered: "),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Text(
                              "$numEmployees",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Visibility(
                                visible: checkDate(),
                                child: Text(
                                    "WARNING: This contract is about to expiry, please renew it before ${tenantInfo['contractExpiry']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.red))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 350,
                            child: Visibility(
                                visible: checkDate(),
                              child: ElevatedButton(
                                  onPressed: () {
                                    sendEmail();
                                  },
                                  child: Text("send email")),
                            ),
                          ),

                        ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  bool checkDate() {
    //split currentDate and expiryDate
    String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
    List<String> currentDateSplit = currentDate.split('-');
    String expiryDate = tenantInfo['contractExpiry'];
    List<String> expiryDateSplit = expiryDate.split('-');

    //get values for each time construct
    int year = int.parse(expiryDateSplit[0]) - int.parse(currentDateSplit[0]);
    int month = int.parse(expiryDateSplit[1]) - int.parse(currentDateSplit[1]);
    int day = int.parse(expiryDateSplit[2]) - int.parse(currentDateSplit[2]);

    //calculate total days < 3 months (3*30 days)
    //3 months period for contract expiry notice
    int totalDays = year * 365 + month * 30 + day;

    return totalDays < 90;
  }

  void sendEmail() async {
    //add checklist AUTOMATICALLY to body
    String body = "THIS IS AN AUTO GENERATED MESSAGE \n please renew your contract before ${tenantInfo['contractExpiry']}";
    String subject = "Contract expiry notice for ${tenantInfo['shopName']}";
    String recipient = "";
    for (int i = 0; i < emailList.length; i++){
      recipient += emailList[i];
      recipient += ';';
    }

    final Uri params = Uri(
        scheme: 'mailto',
        path: recipient,
        query: 'subject=$subject&body=$body');

    String url = params.toString();

    //String url = 'mailto: $recipient?subject=$subject&body=$body';

    try {
      await launch(url);
    } catch (e) {
      print(e);
    }
  }
}
