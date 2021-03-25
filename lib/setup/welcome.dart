import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';
import 'package:singhealth_app/classes/camerascreen.dart';

import '../custom_icons.dart';


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

                child: SizedBox(
                  width: 1024,
                  height: 768,
                  child: Material(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 450,
                          top: 1,
                          child: Image(
                            width: 200,
                            height: 200,
                            image: AssetImage('images/SingHealth_Logo.png'),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 181,
                          child: SizedBox(
                            width: 1111,
                            height: 464,
                            child: Material(
                              color: Color(0xaff19f54),
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 368,
                                    top: 200,
                                    child: RaisedButton(
                                      onPressed: navigateToSignIn,
                                      color: Colors.teal,
                                      child: SizedBox(
                                        width: 300,
                                        height: 42,
                                        child: Text(
                                            'Sign in',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xf2e5e5e5),
                                                fontSize: 24,
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2.40
                                            ),
                                          ),


                                      ),


                                    ),
                                  ),
                                  Positioned(
                                    left: 300,
                                    top: 250,
                                    child: RaisedButton(
                                      onPressed: navigateToSignUp,
                                          color: Colors.transparent,
                                          child: Text(
                                            "Don't have an account? Sign up here",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2.40
                                            ),
                                          ),





                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

<<<<<<< HEAD
              Container(
                  margin: EdgeInsets.all(5),
                  child: RaisedButton.icon(
                    icon: Icon(CustomIcons.sign_in),
                    label: Text("Sign In"),
                    textColor: Colors.white,
                    color: Colors.blue[300],
                    onPressed: navigateToSignIn,
                  ),
              ),

              Container(
                margin: EdgeInsets.all(5),
                child: RaisedButton.icon(
                  icon: Icon(CustomIcons.clipboard_user),
                  label: Text("Sign Up"),
                  textColor: Colors.white,
                  color: Colors.blue[300],
                  onPressed: navigateToSignUp,
                ),
              ),
            ]
        ),
=======
>>>>>>> 4bb58e95f04e0b7756ea73fa5097754db4c2882e
    );
  }

  void navigateToSignIn(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog:true));
  }

  void navigateToSignUp(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp(),fullscreenDialog:true));
  }
}
