import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AdminAccount extends StatefulWidget {
  final User user;
  final dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  AdminAccount({Key key, this.user, this.admin}) : super(key: key);

  @override
  _AdminAccountState createState() => _AdminAccountState(user, admin);
}

class _AdminAccountState extends State<AdminAccount> {
  User user;
  dynamic admin;
  final firestoreInstance = FirebaseFirestore.instance;

  _AdminAccountState(user, admin) {
    this.user = user;
    this.admin = admin;
  }

  bool _isEnabled = false;
  String name, email, institution;

  TextEditingController nameController, emailController, institutionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: admin['name']);
    emailController = TextEditingController(text: admin['email']);
    institutionController = TextEditingController(text: admin['institution']);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    institutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Admin account details'),
        ),
        body: Container(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(

                  // child: ListView.builder(
                  //     // scrollDirection: Axis.horizontal,
                  //     itemCount: 2,
                  //     itemBuilder: (context, i) {
                  //       return Container(
                  //         padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //         height: 220,
                  //         width: double.maxFinite,

                  child: Column(
                    children: [
                      Positioned(
                        left: 150,
                        top: 1,
                        child: Image(
                          width: 200,
                          height: 200,
                          image: AssetImage('images/SingHealth_Logo.png'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 30.0),
                        //padding: const EdgeInsets.fromLTRB( 1000.0, 30.0, 1000.0, 30.0),
                        child: Card(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //padding: const EdgeInsets.fromLTRB(550.0, 35.0, 550.0, 35.0),
                            child: Column(
                              children: [
                                ListTile(
                                  tileColor: Colors.red,
                                  leading: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          switch (_isEnabled) {
                                            case true:
                                              _isEnabled = false;
                                              break;
                                            case false:
                                              _isEnabled = true;
                                              break;
                                          }
                                          updateInfo();
                                        });
                                      }),
                                  title: Center(
                                    child: Text(
                                        "Click Icon Here to Edit Profile Details: ",
                                        textScaleFactor: 1.5,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2.40
                                        ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Name: "),
                                      Container(
                                        alignment: Alignment.center,
                                        //width: 1000,
                                        width: 350,
                                        //MediaQuery.of(context).size.width *0.50,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: nameController,
                                          enabled: _isEnabled,
                                          style: colorDecider(),
                                        ),
                                      ),
                                    ]),
                                SizedBox(width: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Email: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 350,
                                        //MediaQuery.of(context).size.width*0.50,
                                        child: TextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.center,
                                          controller: emailController,
                                          enabled: _isEnabled,
                                          style: colorDecider(),
                                        ),
                                      ),
                                    ]),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Institution: "),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 350,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: institutionController,
                                            enabled: false,
                                            style:
                                                TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 2.40
                                                ),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //   );
                  // }),
                ),
              ]),
        ));
  }

  // Stack(children: <Widget>[
  //   Align(
  //     alignment: Alignment.centerRight,
  //     child: Stack(children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10, top: 5),
  //         child: Column(
  //           children: <Widget>[
  //             // const ListTile(
  //             //   title: Text('Your Profile Details',
  //             //       textAlign: TextAlign.center),
  //             //   subtitle: Text("click the icon to edit",
  //             //       textAlign: TextAlign.center),
  //             // ),
  //           ],
  //         ),
  //       ),
  //     ]),

  TextStyle colorDecider() {
    if (_isEnabled == true) {
      return TextStyle(color: Colors.grey);
    } else {
      return TextStyle(color: Colors.black);
    }
  }

  void updateInfo() {
    try {
      var message;
      user
          .updateEmail(emailController.text)
          .then((value) => message = 'Success')
          .catchError((onError) => message = 'error');

      FirebaseFirestore.instance.collection('admin').doc(user.uid).update({
        'name': nameController.text,
        'email': emailController.text,
      });
      Toast.show("Successfully changed details", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
