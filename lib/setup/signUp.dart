import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String _role = "Staff";
  int id = 1;
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
                          _role = 'Staff';
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
                          _role = 'Tenant';
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
                ElevatedButton(onPressed: signUp,
                  child: Text('Sign Up'),
                )
              ],
            )
        )
    );
  }

  void signUp() async{
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try{
        User user = await FirebaseFunctions.createUser(_email,_password);

        //staff signup
        if (id == 1){
          Staff newStaff = new Staff(_name,_email,user.uid,"Singapore General Hospital");
          FirebaseFunctions.createStaffWithEmailPassword(_name,_email,newStaff);
        }

        //tenant signup
        else if(id == 2){
          Tenant newTenant = new Tenant(_name,_email,user.uid,"Manager","Singapore General Hospital");
          FirebaseFunctions.createTenantWithEmailPassword(_email, _password, newTenant);
        }

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
      }catch(e){
        print(e.toString());

      }
    }
  }


}
