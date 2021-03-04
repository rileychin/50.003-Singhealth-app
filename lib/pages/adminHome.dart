import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';


class AdminHome extends StatefulWidget {
  @override
  AdminHome({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;


  _AdminHomeState createState() => _AdminHomeState(user,firestoreInstance);
}

class _AdminHomeState extends State<AdminHome> {

  User user;
  FirebaseFirestore firestoreInstance;

  dynamic data;

  _AdminHomeState(user,firestoreInstance){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }


  Future<dynamic> adminInformation() async {

    final DocumentReference document = firestoreInstance.collection("admin").doc(user.uid);
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data();
      });
    });
  }

  @override
  void initState(){
    super.initState();
    adminInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Welcome ${data["name"]}, you are logged in as admin for ${data['institution']}'),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 500),
                  padding: EdgeInsets.all(25),
                  color: Colors.green[100],
                  child: Row(
                    children: <Widget> [
                      Column(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Name: ${data["name"]}"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Branch Location: ${data["institution"]}"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Admin Number: ${data["id"]}"),
                          ),
                        ],
                      ),

                    ],
                  )
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 500),
                  padding: EdgeInsets.all(25),
                  color: Colors.orange[100],
                  child: Row(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 10, 135, 10),
                        child: Text("Account & Institution"),
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.clipboard_user), onPressed: null),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text("Account"),
                          ),
                        ],
                      ),

                      Column(
                        children: <Widget> [
                          IconButton(icon: Icon(CustomIcons.document), onPressed: navigateToAddDeleteTenant),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Text("Add / Delete Tenant at this institution"),
                          ),
                        ],
                      ),
                    ],
                  )
              ),

              RaisedButton.icon(
                icon: Icon(CustomIcons.sign_out),
                label: Text("Sign Out"),
                textColor: Colors.white,
                color: Colors.blue[300],
                onPressed: signOut,
              ),
            ]
        ),
      ),
    );
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> WelcomePage()));
  }

  void navigateToAddDeleteTenant() {
    //TODO: navigate to add and delete tenant page
    //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> adminAddDeleteTenant(user:user,)));
  }
}

