import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/Pages/home.dart';
import 'package:singhealth_app/setup/signIn.dart';

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
          title: Text('Sign in'),
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
                ElevatedButton(onPressed: signIn,
                  child: Text('Sign Up'),
                )
              ],
            )
        )
    );
  }

  void signIn() async{
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        //Display for the user that we sent an email
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
      }catch(e){
        print(e.message);

      }
    }
  }
}
