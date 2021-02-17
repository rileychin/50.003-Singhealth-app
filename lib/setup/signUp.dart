import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
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
        Firebase.initializeApp();
        UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        User user = result.user;

        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "name" : "riley",
          "type" : "admin",
          "email" : _email,
        });

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
      }catch(e){
        print(e.toString());

      }
    }
  }
}
