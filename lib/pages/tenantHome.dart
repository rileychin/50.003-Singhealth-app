import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/Pages/tenantAccount.dart';
import 'package:singhealth_app/Pages/tenantContractDetails.dart';
import 'package:singhealth_app/classes/firebase.dart';
import 'package:singhealth_app/pages/tenantAuditChecklistFnB.dart';
import 'package:singhealth_app/pages/tenantAuditChecklistNonFnB.dart';
import 'package:singhealth_app/classes/institution.dart';
import 'package:singhealth_app/classes/tenant.dart';
import 'package:singhealth_app/custom_icons_icons.dart';
import 'package:singhealth_app/setup/welcome.dart';
import 'package:singhealth_app/pages/tenantNoncomplianceReport.dart';


class TenantHome extends StatefulWidget {
  @override
  TenantHome({
    Key key,
    this.user}) : super(key: key);

  final User user;
  final firestoreInstance = FirebaseFirestore.instance;

  _TenantHomeState createState() => _TenantHomeState(user,firestoreInstance);
}

class _TenantHomeState extends State<TenantHome> {
  User user;
  FirebaseFirestore firestoreInstance;

  dynamic data,tenantInfo;

  _TenantHomeState(user, firestoreInstance){
    this.user = user;
    this.firestoreInstance = firestoreInstance;
  }

  Future<dynamic> tenantInformation() async{
    final DocumentReference document =   firestoreInstance.collection("tenant").doc(user.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data = snapshot.data();
      });
    });

    await firestoreInstance.collection('institution').doc(data['institution']).collection('tenant').doc(data['shopName']).get().then((value)  async{
      setState(() {
        tenantInfo = value.data();
      });
    });
  }

  @override
  void initState(){
    super.initState();
    tenantInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || tenantInfo == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${data["name"]}, you are logged in as tenant'),
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
                        child: Text("Role: ${data["position"]}"),
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
                        child: Text("Tenancy Number: ${data["id"]}"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Shop Name: ${tenantInfo['shopName']}"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Contract Expiry: ${tenantInfo['contractExpiry']}"),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage('images/PolarLogo.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
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
                      child: Text("Account & Tenancy"),
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.clipboard_user), onPressed: navigateToTenantAccount),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text("Account"),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.clipboard_checklist), onPressed: navigateToTenantAuditChecklist),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                          child: Text("Audit Checklist"),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.document), onPressed: navigateToTenantContractDetails),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text("Contract Details"),
                        ),
                      ],
                    ),
                  ],
                )
            ),

            Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 500),
                padding: EdgeInsets.all(25),
                color: Colors.red[100],
                child: Row(
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 10, 50, 10),
                      child: Text("Non-compliance Incidents"),
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.calendar_exclamation), onPressed: navigateToTenantNoncomplianceReport),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text("View non-compliance incidents"),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.history), onPressed: null),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text("Past Reports"),
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomePage()));
  }

  void navigateToTenantNoncomplianceReport() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => TenantViewNoncompliance(user: user)));
  }

  void navigateToTenantAuditChecklist() async{

    List<dynamic> NonFnBTenantList = await FirebaseFunctions.getInstitutionNonFnBTenants(data['institution']);
    NonFnBTenantList = Institution.convertToStringList(NonFnBTenantList);

    if (NonFnBTenantList.contains(data['shopName'])) {
      Navigator.push(context, MaterialPageRoute(builder:(context) => TenantAuditChecklistNonFnB(user: user, tenant: data)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder:(context) => TenantAuditChecklistFnB(user: user, tenant: data)));
    }
  }

  void navigateToTenantAccount() {
    Navigator.push(context, MaterialPageRoute(builder:(context) => TenantAccount(user: user, tenant: data,tenantInfo: tenantInfo)));
  }

  void navigateToTenantContractDetails() {
    Navigator.push(context, MaterialPageRoute(builder:(context) => TenantContractDetails(user: user, tenant: data,tenantInfo: tenantInfo)));
  }
}
