
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:singhealth_app/Pages/staffHome.dart';
import 'package:singhealth_app/Pages/tenantHome.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/setup/welcome.dart';



class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Form(
          key: _formKey,
            child: Column(
            children: <Widget>[
              //TODO: Implement fields
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password needs to be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                onFieldSubmitted: (value) {
                  signIn();
                },
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: signIn,
                    child: Text('Sign In'),
                  )
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: back,
                    child: Text('Go Back'),
                  )
              ),
          ],
        )
      )
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try{
        Firebase.initializeApp();
        UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        User user = result.user;
        //authentication works but Home not implemented

        final firestoreInstance = FirebaseFirestore.instance;
        DocumentSnapshot snapshot = await firestoreInstance.collection("users").doc(user.uid).get();

        if (snapshot.exists) {
          String role = snapshot.data()['role'];

          if (role == 'tenant'){
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => TenantHome(user:user)));
          }
          else if (role == 'staff'){
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => StaffHome(user:user)));
          }
          else if (role == 'admin'){
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => AdminHome(user:user)));
          }
        }
      } catch(e) {
        print(e);
      }
    }
  }

  void back() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
