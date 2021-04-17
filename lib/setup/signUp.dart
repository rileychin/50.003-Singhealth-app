import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/admin.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/classes/staff.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/tenant.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:singhealth_app/setup/welcome.dart';

import '../custom_icons.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _name;
  String _institution = 'CGH';
  //FOR TENANT ONLY
  String _position,_shopName;
  //bool _isFnB = true;
  DateTime contractExpiryDate;

  List<dynamic> NonFnBTenantList,FnBTenantList;
  List<String> FullTenantList;
  //1 == staff, 2 == tenant
  int id = 1;


  //Institution and corresponding tenants
  List<String> _institutions = ['CGH','KKH','SGH','SKH','NCCS','NHCS','BVH','OCH','Academia'];
  List<String> _shopNameList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getTenantList()async{
    try{
    await FirebaseFirestore.instance.collection('institution').doc(_institution).get().then<dynamic>(( DocumentSnapshot snapshot) async{
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
    // TODO: implement initState
    super.initState();
    getTenantList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: SizedBox(
                        width: 1024,
                        height: 700,
                        child: Material(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 450,
                                top: 1,
                                child: Image(
                                  width: 100,
                                  height: 100,
                                  image: AssetImage('images/SingHealth_Logo.png'),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  left: 0,
                                  top: 200,
                                  child: SizedBox(
                                    width: 1111,
                                    height: 500,
                                    child: Material(
                                      color: Color(0xaff19f54),
                                      borderRadius: BorderRadius.circular(8),

                                    ),

                                  ),
                                ),
                              ),
                              Center(
                                    child: Positioned(
                                      child: Align(
                                        alignment: Alignment(0.0,-0.6),
                                      //TODO: Implement fields
                                      child: TextFormField(

                                        key:ValueKey("name"),
                                        validator:(input){
                                          if (input.isEmpty){
                                            return 'Please enter a name';
                                          }
                                        },
                                        onSaved: (input) => _name = input,
                                        decoration: InputDecoration(
                                            labelText: 'Name'
                                        ),
                                      ),
                                    ),
                                    ),
                              ),
                              Center(
                                child: Positioned(
                                  child: Align(
                                    alignment: Alignment(0.0,-0.4),
                                  child:TextFormField(
                                    key:ValueKey("email"),
                                    validator:(input){
                                      if (input.isEmpty){
                                        return 'Please type an email';
                                      }
                                    },
                                    onSaved: (input) => _email = input,
                                    decoration: InputDecoration(
                                        labelText: 'Email'
                                    ),
                                  ),
                                ),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  child: Align(
                                    alignment: Alignment(0.0,-0.2),
                                    child:TextFormField(
                                      key:ValueKey("password"),
                                      validator:(input){
                                        if (input.length < 6){
                                          return 'Your password needs to be at least 6 characters';
                                        }
                                      },
                                      onSaved: (input) => _password = input,
                                      decoration: InputDecoration(
                                          labelText: 'Password'
                                      ),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child:Positioned(
                                  child: Align(
                                    alignment: Alignment(0.0,0.0),
                                  child:DropdownButton(
                                    key:ValueKey("institution"),
                                    hint: Text('Please choose an institution'),
                                    value: _institution,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _shopName = null; //set to null when changed so no contention
                                        _institution = newValue;
                                        getTenantList(); //getTenantList() does not finish fast enough to assign FullTenantList to _shopNameList
                                      });
                                    },
                                    items: _institutions.map((institution) {
                                      return DropdownMenuItem(
                                        child: new Text(institution),
                                        value: institution,
                                      );
                                    }).toList(),
                                  ),
                                ) ,
                                ),
                              ),
                              Center(
                                child: Align(
                                  alignment: Alignment(0.0,0.2),
                                child: Positioned(
                                  child:Text(
                                    'I am signing up as a: ',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  child: Align(
                                    alignment: Alignment(0.0,0.4),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Radio(
                                          key: ValueKey("admin"),
                                          value: 0,
                                          groupValue: id,
                                          onChanged: (val) {
                                            setState(() {
                                              //Admin login
                                              id = 0;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Admin',
                                          style: new TextStyle(fontSize: 17.0),
                                        ),
                                        Radio(
                                          key: ValueKey("staff"),
                                          value: 1,
                                          groupValue: id,
                                          onChanged: (val) {
                                            setState(() {
                                              //Staff login
                                              id = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Staff',
                                          style: new TextStyle(fontSize: 17.0),
                                        ),
                                        Radio(
                                          key: ValueKey("tenant"),
                                          value: 2,
                                          groupValue: id,
                                          onChanged: (val) {
                                            setState(() {
                                              id = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Tenant',
                                          style: new TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  child: Align(
                                    alignment: Alignment(0.2,0.6),
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: RaisedButton.icon(
                                        icon: Icon(CustomIcons.clipboard_user),
                                        label: Text("Sign Up"),
                                        textColor: Colors.white,
                                        color: Colors.blue[300],
                                        onPressed: signUp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  child: Align(
                                    alignment: Alignment(-0.2,0.6),
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: RaisedButton.icon(
                                        icon: Icon(CustomIcons.backward),
                                        label: Text("Go Back"),
                                        textColor: Colors.white,
                                        color: Colors.blue[300],
                                        onPressed: back,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),






                Visibility(
                  visible: checkAdmin(),
                  child:
                  TextFormField(
                    key: ValueKey("secret"),
                    validator:(input){
                      if (input != "admin"){
                        return 'The secret password does not match';
                      }
                    },
                    onSaved: (input) => _position = input,
                    decoration: InputDecoration(
                        labelText: 'SUPER duper whooper Secret "admin" password only'
                    ),
                  ),
                ),
                Visibility(
                  visible: checkTenant(),
                  child:
                  TextFormField(
                    key: ValueKey("position"),
                    validator:(input){
                      if (input.isEmpty){
                        return 'Please enter your position';
                      }
                    },
                    onSaved: (input) => _position = input,
                    decoration: InputDecoration(
                        labelText: 'Position'
                    ),
                  ),
                ),
                Visibility(
                  visible: checkTenant(),
                  child:
                  DropdownButton(
                    key: ValueKey("shopName"),
                    hint: Text('Please select your shop'),
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
                ),
                //TODO: ADD CONTRACT EXPIRY DATE when the time comes



                Container(
                  margin: EdgeInsets.all(5),

                ),
              ],
            )
        )
    );
  }

  bool checkTenant() {
    if (id == 2){
      return true;
    }
    else return false;
  }

  bool checkAdmin(){
    if (id == 0){
      return true;
    }
    else return false;
  }

  void signUp() async{
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try {
        User user = await FirebaseFunctions.createUser(_email,_password);

        //staff signup
        if (id == 1){
          Staff newStaff = new Staff(_name,_email,user.uid,_institution);
          FirebaseFunctions.createStaffWithEmailPassword(_name,_email,newStaff);
        }

        //tenant signup
        else if(id == 2){
          Tenant newTenant = new Tenant(_name,_email,user.uid,_position,_institution,_shopName);
          FirebaseFunctions.createTenantWithEmailPassword(_email, _password, newTenant);
        }

        //admin signup
        else if (id == 0){
          Admin newAdmin = new Admin(_name,_email,user.uid,_institution);
          FirebaseFunctions.createAdminWithEmailPassword(_email, _password, newAdmin);
        }

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
      } catch(e) {
        print(e.toString());
      }
    }
  }

  void back() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
