import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:toast/toast.dart';

class TenantContractDetails extends StatefulWidget {

  final User user;
  final dynamic tenant,tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;

  TenantContractDetails({
    Key key,
    this.user,
    this.tenant,
    this.tenantInfo}) : super(key: key);


  @override
  _TenantContractDetailsState createState() => _TenantContractDetailsState(user,tenant,tenantInfo);
}

class _TenantContractDetailsState extends State<TenantContractDetails> {

  User user;
  dynamic tenant,tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;



  _TenantContractDetailsState(user,tenant,tenantInfo){
    this.user = user;
    this.tenant = tenant;
    this.tenantInfo = tenantInfo;
  }

  bool _isEnabled = false;
  String name,email,institution;

  TextEditingController
  nameController,emailController,institutionController,
      positionController,contractExpiryController,shopNameController,dateJoinedController,
      unitNumberController,phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: tenant['name']);
    emailController = TextEditingController(text: tenant['email']);
    institutionController = TextEditingController(text: tenant['institution']);
    positionController = TextEditingController(text: tenant['position']);
    contractExpiryController = TextEditingController(text: tenantInfo['contractExpiry']);
    shopNameController = TextEditingController(text: tenantInfo['shopName']);
    dateJoinedController = TextEditingController(text: tenantInfo['dateJoined']);
    unitNumberController = TextEditingController(text: tenantInfo['unitNumber']);
    phoneNumberController = TextEditingController(text: tenantInfo['phoneNumber']);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    institutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tenant contract details'),
        ),
        body:
        Align(
          alignment: Alignment.center,
          child:
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Contract Summary: "),
                ],
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Shop Name: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenantInfo['shopName']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Institution: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenant['institution']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Contract Expiry: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenantInfo['contractExpiry']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Date Joined: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenantInfo['dateJoined']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Unit Number: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenantInfo['unitNumber']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Phone Number: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Text("${tenantInfo['phoneNumber']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Visibility(
                visible: checkDate(),
                  child:
                  Text("WARNING: Your contract is about to expiry, please renew it before ${tenantInfo['contractExpiry']}",
                      style : TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.red)))
            ],
          ),
        )
    );
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
    int totalDays = year*365 + month*30 + day;

    if (totalDays > 90){
      return false;
    }
    return true;

  }



}
