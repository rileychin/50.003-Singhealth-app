
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

// //trying out UI from scratch
// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My firebase app'),
//       ),
//       body: Container(
//         child:
//             Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           Row(children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.black26,
//               ),
//             ),
//           ]),
//           Row(children: [
//             Container(
//               height: 100.0,
//               width: 100.0,
//               color: Colors.orange,
//             ),
//           ]),
//           Row(children: [
//             Container(
//               height: 100.0,
//               width: 100.0,
//               color: Colors.yellow,
//             ),
//           ]),
//           Row(children: [
//             Container(
//               height: 100.0,
//               width: 100.0,
//               color: Colors.green,
//             ),
//           ]),
//           Row(children: [
//             Container(
//               height: 100.0,
//               width: 100.0,
//               color: Colors.blue,
//             ),
//           ]),
//         ]),
//       ),
//     );
//   }

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My firebase app'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNarrowContainer();
          }
        },
      ),
    );
  }

  Widget _buildWideContainers() {
    return Center(
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
                                  width: 200,
                                  height: 200,
                                  image: AssetImage('images/SingHealth_Logo.png'),
                                ),
                              ),
                              Center(
                                child: Positioned(
                                  left: 0,
                                  top: 200,
                                  child: SizedBox(
                                    width: 1111,
                                    height: 300,
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
                                                      letterSpacing: 2.40),
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
                                                    letterSpacing: 2.40),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            ]));
  }

  Widget _buildNarrowContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('images/SingHealth_Logo.png'),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    // height: 100.0,
                    // width: 100.0,
                    // color: Colors.yellow,
                    child: SizedBox(
                      width: 1111,
                      height: 464,
                      child: Material(
                        color: Color(0xaff19f54),
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 145,
                              top: 200,
                              child: RaisedButton(
                                onPressed: navigateToSignIn,
                                color: Colors.teal,
                                child: SizedBox(
                                  width: 250,
                                  height: 42,
                                  child: Text(
                                    'Sign in',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xf2e5e5e5),
                                        fontSize: 20,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2.40),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 65,
                              top: 250,
                              child: RaisedButton(
                                onPressed: navigateToSignUp,
                                color: Colors.transparent,
                                child: Text(
                                  "Don't have an account? Sign up here",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2.40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(), fullscreenDialog: true));
  }
}