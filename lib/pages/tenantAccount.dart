import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/custom_icons.dart';
import 'package:toast/toast.dart';

class TenantAccount extends StatefulWidget {
  final User user;
  final dynamic tenant, tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;

  TenantAccount({Key key, this.user, this.tenant, this.tenantInfo})
      : super(key: key);

  @override
  _TenantAccountState createState() =>
      _TenantAccountState(user, tenant, tenantInfo);
}

class _TenantAccountState extends State<TenantAccount> {
  User user;
  dynamic tenant, tenantInfo;
  final firestoreInstance = FirebaseFirestore.instance;

  _TenantAccountState(user, tenant, tenantInfo) {
    this.user = user;
    this.tenant = tenant;
    this.tenantInfo = tenantInfo;
  }

  bool _isEnabled = false;
  String name, email, institution;

  TextEditingController nameController,
      emailController,
      institutionController,
      positionController,
      contractExpiryController,
      shopNameController,
      dateJoinedController,
      unitNumberController,
      phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: tenant['name']);
    emailController = TextEditingController(text: tenant['email']);
    institutionController = TextEditingController(text: tenant['institution']);
    positionController = TextEditingController(text: tenant['position']);
    contractExpiryController =
        TextEditingController(text: tenantInfo['contractExpiry']);
    shopNameController = TextEditingController(text: tenantInfo['shopName']);
    dateJoinedController =
        TextEditingController(text: tenantInfo['dateJoined']);
    unitNumberController =
        TextEditingController(text: tenantInfo['unitNumber']);
    phoneNumberController =
        TextEditingController(text: tenantInfo['phoneNumber']);
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
          title: Text('Tenant account details'),
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
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 30.0),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              ListTile(
                                tileColor: Colors.blue,
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
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Name: "),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 500,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Email: "),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 500,
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
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Position: "),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 500,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: positionController,
                                        enabled: _isEnabled,
                                        style: colorDecider(),
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Institution: "),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 500,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: institutionController,
                                        enabled: false,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(500.0, 30.0, 500.0, 30.0),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              ListTile(
                                tileColor: Colors.grey,
                                title: Center(
                                  child: Text(
                                    "General Tenancy Details: ",
                                    textScaleFactor: 1.5,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Shop Name: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenantInfo['shopName']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Institution: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenant['institution']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Contract Expiry: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenantInfo['contractExpiry']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Date Joined: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenantInfo['dateJoined']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Unit Number: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenantInfo['unitNumber']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Phone Number: "),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 500,
                                        child: Text(
                                          "${tenantInfo['phoneNumber']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //   );
                  // }),
                ),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            // const ListTile(
                            //   title: Text('Your Profile Details',
                            //       textAlign: TextAlign.center),
                            //   subtitle: Text("click the icon to edit",
                            //       textAlign: TextAlign.center),
                            // ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ]),
              ]),
        ));
  }

  // Align(
  //   alignment: Alignment.topCenter,
  //   child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Card(
  //         elevation: 5,
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               const ListTile(
  //                 title: Text('Your Profile Details',
  //                     textAlign: TextAlign.center),
  //                 subtitle: Text("click the icon to edit",
  //                     textAlign: TextAlign.center),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   IconButton(
  //                       icon: Icon(Icons.edit),
  //                       onPressed: () {
  //                         setState(() {
  //                           switch (_isEnabled) {
  //                             case true:
  //                               _isEnabled = false;
  //                               break;
  //                             case false:
  //                               _isEnabled = true;
  //                               break;
  //                           }
  //                           updateInfo();
  //                         });
  //                       }),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Name: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: TextField(
  //                         textAlign: TextAlign.center,
  //                         controller: nameController,
  //                         enabled: _isEnabled,
  //                         style: colorDecider(),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(width: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Email: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: TextField(
  //                         keyboardType: TextInputType.emailAddress,
  //                         textAlign: TextAlign.center,
  //                         controller: emailController,
  //                         enabled: _isEnabled,
  //                         style: colorDecider(),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Position: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: TextField(
  //                         textAlign: TextAlign.center,
  //                         controller: positionController,
  //                         enabled: _isEnabled,
  //                         style: colorDecider(),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Institution: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: TextField(
  //                         textAlign: TextAlign.center,
  //                         controller: institutionController,
  //                         enabled: false,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     "General Tenancy Details: ",
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Shop Name: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenantInfo['shopName']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Institution: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenant['institution']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Contract Expiry: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenantInfo['contractExpiry']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Date Joined: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenantInfo['dateJoined']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Unit Number: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenantInfo['unitNumber']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //               SizedBox(height: 10),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Text("Phone Number: "),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       width: 1000,
  //                       child: Text(
  //                         "${tenantInfo['phoneNumber']}",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ]),
  //             ],
  //           ),
  //         ),
  //       )),
  // ),
  //   );
  // }

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

      FirebaseFirestore.instance.collection('tenant').doc(user.uid).update({
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
