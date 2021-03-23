import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My firebase app'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [

              Align(
                alignment: Alignment.center,
                child:
                Container(
                  margin: EdgeInsets.all(100),
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('images/SingHealth_Logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: navigateToSignIn,
                    child: Text('Sign In'),
                  )
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: navigateToSignUp,
                    child: Text('Sign Up'),
                  )
              ),
            ]
        ),
    );
  }

  void navigateToSignIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigateToSignUp(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
