import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:toast/toast.dart';

class TenantAccount extends StatefulWidget {

  final User user;
  final dynamic tenant,tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;

  TenantAccount({
    Key key,
    this.user,
    this.tenant,
    this.tenantInfo}) : super(key: key);


  @override
  _TenantAccountState createState() => _TenantAccountState(user,tenant,tenantInfo);
}

class _TenantAccountState extends State<TenantAccount> {

  User user;
  dynamic tenant,tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;



  _TenantAccountState(user,tenant,tenantInfo){
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
          title: Text('Tenant account details'),
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
                  Text("Profile Details: "),
                  IconButton(icon: Icon(Icons.edit),
                      onPressed: (){
                        setState(() {
                          switch(_isEnabled){
                            case true:
                              _isEnabled = false;
                              break;
                            case false:
                              _isEnabled = true;
                              break;
                          }
                          updateInfo();
                        });
                      }),
                ],
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Name: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: nameController,
                        enabled: _isEnabled,
                        style: colorDecider(),
                      ),
                    ),
                  ]
              ),
              SizedBox(width:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Email: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        controller: emailController,
                        enabled: _isEnabled,
                        style: colorDecider(),
                      ),
                    ),
                  ]
              ),
              SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text("Position: "),
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: positionController,
                        enabled: _isEnabled,
                        style: colorDecider(),
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
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: institutionController,
                        enabled: false,
                        style: TextStyle(color:Colors.black),
                      ),
                    ),
                  ]
              ),

              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Tenancy Details: "),
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
            ],
          ),
        )
    );
  }

  TextStyle colorDecider() {
    if (_isEnabled == true){
      return TextStyle(color:Colors.grey);
    }
    else{
      return TextStyle(color:Colors.black);
    }
  }

  void updateInfo() {
    try{
      var message;
      user.updateEmail(emailController.text).then((value) => message = 'Success').catchError((onError) => message = 'error');

      FirebaseFirestore.instance.collection('tenant').doc(user.uid).update({
        'name' : nameController.text,
        'email' : emailController.text,
      });
      Toast.show("Successfully changed details", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }catch(e){print(e);}
  }

}
