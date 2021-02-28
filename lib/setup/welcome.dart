import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/classes/uploadphoto.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';
import 'package:singhealth_app/classes/camerascreen.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('My firebase app'),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          ElevatedButton(
          onPressed: navigateToSignIn,
              child: Text('Sign in'),
          ),
          ElevatedButton(
            onPressed: navigateToSignUp,
            child: Text('Sign up'),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("camera"),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => UploadPhoto()));
}   ));
  }

  void navigateToSignIn(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog:true));
  }

  void navigateToSignUp(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp(),fullscreenDialog:true));
  }
}
