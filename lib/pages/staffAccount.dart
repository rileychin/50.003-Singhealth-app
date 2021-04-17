import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:toast/toast.dart';

class StaffAccount extends StatefulWidget {
  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  StaffAccount({Key key, this.user, this.staff}) : super(key: key);

  @override
  _StaffAccountState createState() => _StaffAccountState(user, staff);
}

class _StaffAccountState extends State<StaffAccount> {
  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  _StaffAccountState(user, staff) {
    this.user = user;
    this.staff = staff;
  }

  bool _isEnabled = false;
  String name, email, institution;

  TextEditingController nameController, emailController, institutionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: staff['name']);
    emailController = TextEditingController(text: staff['email']);
    institutionController = TextEditingController(text: staff['institution']);
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
        backgroundColor: Colors.amber,
        title: Text('Staff account details'),
      ),
      body: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 30.0),
                    child: Card(
                      elevation: 5,
                      child: Column(children: [
                        ListTile(
                          tileColor: Colors.amber[300],
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
                              "Your Profile Details: ",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Name: "),
                                Container(
                                  alignment: Alignment.center,
                                  width: 350,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: nameController,
                                    enabled: _isEnabled,
                                    style: colorDecider(),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Email: "),
                                Container(
                                  alignment: Alignment.center,
                                  width: 350,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.center,
                                    controller: emailController,
                                    enabled: _isEnabled,
                                    style: colorDecider(),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Institution: "),
                                Container(
                                  alignment: Alignment.center,
                                  width: 350,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: institutionController,
                                    enabled: false,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(width: 10),
                      ]),
                    ),
                  ),
                ]),
              ),
            ]),
      ),
    );
  }

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

      FirebaseFirestore.instance.collection('staff').doc(user.uid).update({
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
