import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';
import 'package:singhealth_app/classes/checklistQuestions.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffAuditDetailsNonFnBTwo extends StatefulWidget {
  final User user;
  final dynamic staff, auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;
  final String tenantName;
  final DocumentReference tenantReference;

  StaffAuditDetailsNonFnBTwo(
      {Key key,
      this.user,
      this.staff,
      this.tenantName,
      this.tenantReference,
      this.auditChecklist})
      : super(key: key);

  @override
  _StaffAuditDetailsFnBTwoState createState() => _StaffAuditDetailsFnBTwoState(
      user, staff, tenantName, tenantReference, auditChecklist);
}

class _StaffAuditDetailsFnBTwoState extends State<StaffAuditDetailsNonFnBTwo> {
  User user;
  dynamic staff, auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  _StaffAuditDetailsFnBTwoState(
      user, staff, tenantName, tenantReference, auditChecklist) {
    this.user = user;
    this.staff = staff;
    this.tenantName = tenantName;
    this.tenantReference = tenantReference;
    this.auditChecklist = auditChecklist;
  }

  @override
  Widget build(BuildContext context) {
    if (auditChecklist == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('$tenantName ${auditChecklist['date']} audit checklist'),
        ),
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100.0, 16.0, 50.0, 0),
                      child: Column(
                        children: <Widget>[
                          Text("Date of audit: ${auditChecklist['date']}"),
                          SizedBox(height: 10),
                          Text("Auditee: $tenantName"),
                          SizedBox(height: 10),
                          Text("Auditor: ${staff["name"]}"),
                          SizedBox(height: 10),
                          Text("Comments: ${auditChecklist['comments']}"),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
                      child: Column(
                        children: <Widget>[
                          //1. Professionalism & Staff Hygiene (20%)
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.amber[300],
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      "1. Professionalism & Staff Hygiene (20%)",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text("Professionalism",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              SizedBox(height: 10),
                              LabeledCheckbox(
                                  label:
                                      'Shop is open and ready to service patients/visitors according to operating hours.	',
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][0],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Staff Attendance: adequate staff for peak and non-peak hours."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][1],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("At least one (1) clearly assigned person in-charge on site."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][2],
                                  onChanged: null),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text("Staff Hygiene",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              SizedBox(height: 10),
                              LabeledCheckbox(
                                  label:
                                      ("Staff uniform/attire is not soiled."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][3],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Staff who are unfit for work due to illness should not report to work)."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][4],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Staff who are fit for work but suffering from the lingering effects of a cough and/or cold should cover their mouths with a surgical mask.	"),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'professionalismAndStaffHygiene'][5],
                                  onChanged: null),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Visibility(
                                    child: Text(
                                        "Score: ${auditChecklist['professionalismAndStaffHygieneScore']}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue))),
                              ),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                            ],
                          ),

                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.amber[300],
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      "2. Housekeeping & General Cleanliness (40%)",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text(
                                        "General Environment Cleanliness",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              LabeledCheckbox(
                                  label:
                                      ("Adequate and regular pest control.(	Pest control record.)"),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][0],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Goods and equipment are within shop boundary."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][1],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Store display/ Shop front is neat and tidy."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][2],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Work/ serving area is neat, clean and free of spillage."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][3],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Uncluttered circulation space free of refuse/ furniture."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][4],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Fixtures and fittings including shelves, cupboards and drawers are clean and dry and in a good state."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][5],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Ceiling/ ceiling boards are free from stains/ dust with no gaps."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][6],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Fans and air-con units are in proper working order and clean and free from dust. Proper maintenance and routine cleaning are carried out regularly."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][7],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Equipment is clean, in good condition and serviced.	"),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][8],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Surfaces, walls and ceilings within customer areas are dry and clean."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][9],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Floor within customer areas is clean and dry."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][10],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Waste is properly managed and disposed."
                                          "(	Waste bins are not over-filled. )"
                                          "(	Waste Management: Proper disposal of general waste.)"),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value: auditChecklist[
                                      'houseKeepingAndGeneralCleanliness'][11],
                                  onChanged: null),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Visibility(
                                    child: Text(
                                        "Score: ${auditChecklist['houseKeepingAndGeneralCleanlinessScore']}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue))),
                              ),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                            ],
                          ),

                          //3. Workplace Safety & Health (40%)
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.amber[300],
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      "3. Workplace Safety & Health (40%)",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text("General Safety",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              LabeledCheckbox(
                                  label:
                                      ("MSDS for all industrial chemicals are available and up to date."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [0],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label: ("Proper chemicals storage."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [1],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("All detergent and bottles containing liquids are labelled appropriately."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [2],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("All personnel to wear safety shoes and safety attire where necessary."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [3],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Knives and sharp objects are kept at a safe place."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [4],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Area under the sink should not be cluttered with items other than washing agents."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [5],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Delivery personnel do not stack goods above the shoulder level."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [6],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Stacking of goods does not exceed 600mm from the ceiling and heavy items at the bottom, light items on top."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [7],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Proper signage/ label (fire, hazards, warnings, food stuff) and Exit signs in working order."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [8],
                                  onChanged: null),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text("Fire & Emergency Safety",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              SizedBox(height: 10),
                              LabeledCheckbox(
                                  label:
                                      ("Fire extinguishers access is unobstructed; Fire extinguishers are not expired and employees know how to use them."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [9],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Escape route and exits are unobstructed."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [10],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("First aid box is available and well-equipped."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [11],
                                  onChanged: null),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Visibility(
                                    child: Text("Electrical Safety",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              SizedBox(height: 10),
                              LabeledCheckbox(
                                  label:
                                      ("Electrical sockets are not overloaded – one plug to one socket."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [12],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Plugs and cords are intact and free from exposure/ tension with PSB safety mark."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [13],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Power points that are in close proximity to flammable and/or water sources are installed with a plastic cover.	"),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [14],
                                  onChanged: null),
                              LabeledCheckbox(
                                  label:
                                      ("Electrical panels / DBs are covered."),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  value:
                                      auditChecklist['workplaceSafetyAndHealth']
                                          [15],
                                  onChanged: null),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Visibility(
                                    child: Text(
                                        "Score: ${auditChecklist['workplaceSafetyAndHealthScore']}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue))),
                              ),
                            ],
                          ),

                          //TODO: Add total score
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                                "Total Score: ${auditChecklist['totalScore']}%",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),

                          SizedBox(height: 10),

                          //display warning if totalscore<95
                          Visibility(
                              visible: checkWarning(),
                              child: Text(
                                  "WARNING: Tenant score is currently less than 95%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      color: Colors.red))),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  sendEmail(staff['email'],
                                      '${auditChecklist['date']} audit checklist for $tenantName');
                                },
                                child: Text("send email")),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }

  checkWarning() {
    if (auditChecklist['warning'])
      return true;
    else
      return false;
  }

  void sendEmail(String recipient, String subject) async {
    //add checklist AUTOMATICALLY to body
    String body = "";

    body += "The following are what the tenant has FAILED to comply to \n\n Please acknowledge and rectify immediately \n\n\n";

    //professionalism part
    body += "Professionalism and Staff Hygiene Score:  " +
        auditChecklist['professionalismAndStaffHygieneScore'].toString() +
        " \n\n";
    for (int i = 0;
        i < auditChecklist['professionalismAndStaffHygiene'].length;
        i++) {
      if (!auditChecklist['professionalismAndStaffHygiene'][i]) {
        body +=
            NonFnBChecklistQuestions.professionalismAndStaffHygiene[i] + "\t X\n";
      }
    }
    body += "\n";

    //housekeeping part
    body += "Housekeeping and General Cleanliness Score: " +
        auditChecklist['houseKeepingAndGeneralCleanlinessScore'].toString() +
        " \n\n";
    for (int i = 0;
        i < auditChecklist['houseKeepingAndGeneralCleanliness'].length;
        i++) {
      if (!auditChecklist['houseKeepingAndGeneralCleanliness'][i]) {
        body += NonFnBChecklistQuestions.houseKeepingAndGeneralCleanliness[i] +
            "\t X\n";
      }
    }
    body += "\n";

    //workplace safety and health part
    body += "Workplace safety and Health Score: " +
        auditChecklist['workplaceSafetyAndHealthScore'].toString() +
        " \n\n";
    for (int i = 0;
        i < auditChecklist['workplaceSafetyAndHealth'].length;
        i++) {
      if (!auditChecklist['workplaceSafetyAndHealth'][i]) {
        body += NonFnBChecklistQuestions.workplaceSafetyAndHealth[i] + "\t X\n";
      }
    }
    body += "\n";

    //total score
    body += "Total Score: " + auditChecklist['totalScore'].toString();

    final Uri params = Uri(
        scheme: 'mailto',
        path: staff['email'],
        query: 'subject=$subject&body=$body');

    String url = params.toString();

    //String url = 'mailto: $recipient?subject=$subject&body=$body';

    try {
      await launch(url);
    } catch (e) {
      print(e);
    }
  }
}
