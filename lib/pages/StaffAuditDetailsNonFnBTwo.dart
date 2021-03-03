import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';

class StaffAuditDetailsNonFnBTwo extends StatefulWidget {

  final User user;
  final dynamic staff, auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;
  final String tenantName;
  final DocumentReference tenantReference;


  StaffAuditDetailsNonFnBTwo({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference,
    this.auditChecklist}) : super(key: key);

  @override
  _StaffAuditDetailsFnBTwoState createState() => _StaffAuditDetailsFnBTwoState(user,staff,tenantName,tenantReference,auditChecklist);
}

class _StaffAuditDetailsFnBTwoState extends State<StaffAuditDetailsNonFnBTwo> {

  User user;
  dynamic staff,auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  _StaffAuditDetailsFnBTwoState(user,staff,tenantName,tenantReference,auditChecklist){
    this.user = user;
    this.staff = staff;
    this.tenantName = tenantName;
    this.tenantReference = tenantReference;
    this.auditChecklist = auditChecklist;
  }

  @override
  Widget build(BuildContext context) {
    if (auditChecklist == null) {return CircularProgressIndicator();}
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('$tenantName ${auditChecklist['date']} audit checklist'),
        ),
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.center,
                child : Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Date of audit: ${auditChecklist['date']}"),
                        SizedBox(height:10),
                        Text("Auditee: $tenantName"),
                        SizedBox(height:10),
                        Text("Auditor: ${auditChecklist['date']}"),
                        SizedBox(height:10),
                        Text("Comments: ${auditChecklist['comments']}"),
                        SizedBox(height:10),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        //1. Professionalism & Staff Hygiene (20%)
                        Text("1. Professionalism & Staff Hygiene (20%)"),
                        SizedBox(height:10),
                        Text("Professionalism"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: 'Shop is open and ready to service patients/visitors according to operating hours.	',
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][0],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Staff Attendance: adequate staff for peak and non-peak hours."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][1],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("At least one (1) clearly assigned person in-charge on site."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][2],
                            onChanged: null
                        ),
                        Text("Staff Hygiene"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Staff uniform/attire is not soiled."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][3],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Staff who are unfit for work due to illness should not report to work)."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][4],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Staff who are fit for work but suffering from the lingering effects of a cough and/or cold should cover their mouths with a surgical mask.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['professionalismAndStaffHygiene'][5],
                            onChanged: null
                        ),
                        Text("Score: ${auditChecklist['professionalismAndStaffHygieneScore']}"),
                        SizedBox(height:10),
                        SizedBox(height:10),


                        Text("2. Housekeeping & General Cleanliness (40%)"),
                        SizedBox(height:10),
                        Text("General Evironment Cleanliness"),
                        LabeledCheckbox(
                            label: ("Adequate and regular pest control.(	Pest control record.)"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][0],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Goods and equipment are within shop boundary."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][1],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Store display/ Shop front is neat and tidy."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][2],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Work/ serving area is neat, clean and free of spillage."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][3],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Uncluttered circulation space free of refuse/ furniture."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][4],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Fixtures and fittings including shelves, cupboards and drawers are clean and dry and in a good state."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][5],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Ceiling/ ceiling boards are free from stains/ dust with no gaps."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][6],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Fans and air-con units are in proper working order and clean and free from dust. Proper maintenance and routine cleaning are carried out regularly."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][7],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Equipment is clean, in good condition and serviced.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][8],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Surfaces, walls and ceilings within customer areas are dry and clean."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][9],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Floor within customer areas is clean and dry."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][10],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Waste is properly managed and disposed."
                                "(	Waste bins are not over-filled. )"
                                "(	Waste Management: Proper disposal of general waste.)"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['houseKeepingAndGeneralCleanliness'][11],
                            onChanged: null
                        ),
                        Text("Score: ${auditChecklist['houseKeepingAndGeneralCleanlinessScore']}"),
                        SizedBox(height:10),
                        SizedBox(height:10),

                        //3. Workplace Safety & Health (40%)
                        Text("3. Workplace Safety & Health (40%)"),
                        SizedBox(height:10),
                        Text("General Safety"),
                        LabeledCheckbox(
                            label: ("MSDS for all industrial chemicals are available and up to date."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][0],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Proper chemicals storage."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][1],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("All detergent and bottles containing liquids are labelled appropriately."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][2],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("All personnel to wear safety shoes and safety attire where necessary."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][3],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Knives and sharp objects are kept at a safe place."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][4],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Area under the sink should not be cluttered with items other than washing agents."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][5],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Delivery personnel do not stack goods above the shoulder level."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][6],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Stacking of goods does not exceed 600mm from the ceiling and heavy items at the bottom, light items on top."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][7],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Proper signage/ label (fire, hazards, warnings, food stuff) and Exit signs in working order."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][8],
                            onChanged: null
                        ),
                        Text("Fire & Emergency Safety"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Fire extinguishers access is unobstructed; Fire extinguishers are not expired and employees know how to use them."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][9],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Escape route and exits are unobstructed."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][10],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("First aid box is available and well-equipped."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][11],
                            onChanged: null
                        ),
                        Text("Electrical Safety"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Electrical sockets are not overloaded – one plug to one socket."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][12],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Plugs and cords are intact and free from exposure/ tension with PSB safety mark."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][13],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Power points that are in close proximity to flammable and/or water sources are installed with a plastic cover.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][14],
                            onChanged: null
                        ),
                        LabeledCheckbox(
                            label: ("Electrical panels / DBs are covered."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: auditChecklist['workplaceSafetyAndHealth'][15],
                            onChanged: null
                        ),
                        Text("Score: ${auditChecklist['workplaceSafetyAndHealthScore']}"),

                        //TODO: Add total score
                        Text("Total Score: %${auditChecklist['totalScore']}",
                            style : TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height:10),

                        //display warning if totalscore<95
                        Visibility(
                            visible: checkWarning(),
                            child:
                            Text("WARNING: Tenant score is currently less than 95%",
                                style : TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.red))
                        ),
                      ],
                    )
                  ],
                )
            )
        )

    );
  }

  checkWarning() {if (auditChecklist['warning']) return true; else return false;}
}
