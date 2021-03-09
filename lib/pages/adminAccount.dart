import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:toast/toast.dart';

class AdminAccount extends StatefulWidget {

  final User user;
  final dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  AdminAccount({
    Key key,
    this.user,
    this.admin}) : super(key: key);


  @override
  _AdminAccountState createState() => _AdminAccountState(user,admin);
}

class _AdminAccountState extends State<AdminAccount> {

  User user;
  dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;



  _AdminAccountState(user,admin){
    this.user = user;
    this.admin = admin;
  }

  bool _isEnabled = false;
  String name,email,institution;

  TextEditingController nameController,emailController,institutionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: admin['name']);
    emailController = TextEditingController(text:admin['email']);
    institutionController = TextEditingController(text:admin['institution']);
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
        backgroundColor: Colors.redAccent,
        title: Text('Admin account details'),
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
                  SizedBox(width:10),
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
                  SizedBox(width:10),
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
                  SizedBox(width:10),
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

      FirebaseFirestore.instance.collection('admin').doc(user.uid).update({
        'name' : nameController.text,
        'email' : emailController.text,
      });
      Toast.show("Successfully changed details", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }catch(e){print(e);}
  }

}
