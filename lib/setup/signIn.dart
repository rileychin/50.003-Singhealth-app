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

import '../custom_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 700.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      //TODO: Implement fields
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              key: ValueKey("email"),
                              validator: (input) {
                                if (input.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(input)) {
                                  return 'Please enter valid email format';
                                }
                              },
                              onSaved: (input) => _email = input,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              key: ValueKey("password"),
                              validator: (input) {
                                if (input.length < 6) {
                                  return 'Your password needs to be at least 6 characters';
                                }
                              },
                              onSaved: (input) => _password = input,
                              onFieldSubmitted: (value) {
                                signIn();
                              },
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.all(5),
                        child: RaisedButton.icon(
                          key: ValueKey("sign_in"),
                          icon: Icon(CustomIcons.sign_in),
                          label: Text("Sign In"),
                          textColor: Colors.white,
                          color: Colors.blue[300],
                          onPressed: signIn,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(5),
                        child: RaisedButton.icon(
                          icon: Icon(CustomIcons.backward),
                          label: Text("Go Back"),
                          textColor: Colors.white,
                          color: Colors.blue[300],
                          onPressed: back,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Firebase.initializeApp();
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        User user = result.user;
        //authentication works but Home not implemented

        final firestoreInstance = FirebaseFirestore.instance;
        DocumentSnapshot snapshot =
            await firestoreInstance.collection("users").doc(user.uid).get();

        if (snapshot.exists) {
          String role = snapshot.data()['role'];

          if (role == 'tenant') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TenantHome(user: user)));
          } else if (role == 'staff') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => StaffHome(user: user)));
          } else if (role == 'admin') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdminHome(user: user)));
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void back() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
