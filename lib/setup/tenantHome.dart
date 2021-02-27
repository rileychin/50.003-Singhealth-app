import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:singhealth_app/custom_icons_icons.dart';


class TenantHome extends StatefulWidget {
  @override
  _TenantHomeState createState() => _TenantHomeState();
}

class _TenantHomeState extends State<TenantHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
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
                        child: Text("Name: Tan Ah Seng, David"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Role: Manager"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Branch Location: Changi General Hospital"),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Tenancy Number: 12345678"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: Text("Contract Expiry: 01/01/2022"),
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
                        IconButton(icon: Icon(CustomIcons.clipboard_user), onPressed: null),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text("Account"),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.clipboard_checklist), onPressed: null),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                          child: Text("Audit Checklist"),
                        ),
                      ],
                    ),

                    Column(
                      children: <Widget> [
                        IconButton(icon: Icon(CustomIcons.document), onPressed: null),
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
                        IconButton(icon: Icon(CustomIcons.calendar_exclamation), onPressed: null),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text("Unresolved Incident(s)"),
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
                onPressed: () {},
            ),
          ]
        ),
      ),
    );
  }
}

  /*
  void navigateToSignIn(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog:true));
  }

  void navigateToSignUp(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp(),fullscreenDialog:true));
  }
}
   */
