import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/classes/staff.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/classes/tenant.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

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

  //1 == staff, 2 == tenant
  int id = 1;

  //
  int checkIfChanged = 0;

  //Institution and corresponding tenants
  List<String> _institutions = ['CGH','KKH','SGH','SKH','NCCS','NHCS','BVH','OCH','Academia'];
  List<String> _shopNameList = Institution.fullTenantList('CGH');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //TODO: Implement fields
                TextFormField(
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
                TextFormField(
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
                TextFormField(
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
                DropdownButton(
                  hint: Text('Please choose an institution'),
                  value: _institution,
                  onChanged: (newValue) {
                    setState(() {
                      _institution = newValue;
                      _shopNameList = Institution.fullTenantList(newValue);
                      checkIfChanged = 1;
                    });
                  },
                  items: _institutions.map((institution) {
                    return DropdownMenuItem(
                      child: new Text(institution),
                      value: institution,
                    );
                  }).toList(),
                ),
                Text(
                  'I am signing up as a: ',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
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
                Visibility(
                  visible: checkTenant(),
                  child:
                  TextFormField(
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
                    hint: Text('Please select your shop'),
                    value: _shopName,
                    onChanged: (newValue) {
                      setState(() {
                        _shopName = newValue;
                        _shopNameList = Institution.fullTenantList(_institution);
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
                // Visibility(
                //     visible: checkTenant(),
                //     child:
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             Text(contractExpiryDate.toString()),
                //             ElevatedButton(
                //               child:Text("Contract Expiry Date"),
                //               onPressed: (){
                //                 showDatePicker(
                //                   context: context,
                //                   initialDate: DateTime.now(),
                //                   firstDate: DateTime.now(),
                //                   lastDate: DateTime(2030),
                //                 ).then((date){
                //                   setState(() {
                //                     contractExpiryDate = date;
                //                     Text(contractExpiryDate.toString());
                //                   });
                //                 });
                //               },
                //             )
                //           ],
                //         )
                //
                // ),

                ElevatedButton(onPressed: signUp,
                  child: Text('Sign Up'),
                )
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

  void signUp() async{
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try{
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

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
      }catch(e){
        print(e.toString());

      }
    }
  }


}
