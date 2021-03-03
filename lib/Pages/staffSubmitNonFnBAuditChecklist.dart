import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:singhealth_app/Pages/staffHome.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';
import 'package:toast/toast.dart';

class StaffSubmitNonFnBAuditChecklist extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffSubmitNonFnBAuditChecklist({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference}) : super(key: key);

  @override
  _StaffSubmitNonFnBAuditChecklistState createState() => _StaffSubmitNonFnBAuditChecklistState(user,staff,tenantName,tenantReference);
}

class _StaffSubmitNonFnBAuditChecklistState extends State<StaffSubmitNonFnBAuditChecklist> {


  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  //audit details
  String comment;
  String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  ////Scores lists and total score
  List<bool> professionalismAndStaffHygiene = new List.filled(6,false);
  int professionalismAndStaffHygieneScore = 0;

  List<bool> houseKeepingAndGeneralCleanliness = new List.filled(12,false);
  int houseKeepingAndGeneralCleanlinessScore = 0;

  List<bool> workplaceSafetyAndHealth = new List.filled(16,false);
  int workplaceSafetyAndHealthScore = 0;

  int totalScore = 0;


  _StaffSubmitNonFnBAuditChecklistState(user,staff,tenantName,tenantReference){
    this.user = user;
    this.staff = staff;
    this.tenantName = tenantName;
    this.tenantReference = tenantReference;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Submit Non FnB Audit Checklist'),
      ),
      body:
          SingleChildScrollView(
            child:Align(
                alignment: Alignment.center,
                child:
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Date: $todayDate"),
                        Text("Auditee: $tenantName"),
                        Text("Auditor: ${staff['name']}"),
                        TextFormField( onSaved: (input) => comment = input,
                          decoration: InputDecoration(
                              labelText: 'Comments'
                          ),),

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
                            value: professionalismAndStaffHygiene[0],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[0] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Staff Attendance: adequate staff for peak and non-peak hours."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: professionalismAndStaffHygiene[1],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[1] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("At least one (1) clearly assigned person in-charge on site."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: professionalismAndStaffHygiene[2],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[2] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Staff Hygiene"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Staff uniform/attire is not soiled."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: professionalismAndStaffHygiene[3],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[3] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Staff who are unfit for work due to illness should not report to work)."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: professionalismAndStaffHygiene[4],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[4] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Staff who are fit for work but suffering from the lingering effects of a cough and/or cold should cover their mouths with a surgical mask.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: professionalismAndStaffHygiene[5],
                            onChanged: (bool newValue){
                              setState(() {
                                professionalismAndStaffHygiene[5] = newValue;
                                professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Score: $professionalismAndStaffHygieneScore"),
                        SizedBox(height:10),
                        SizedBox(height:10),


                        Text("2. Housekeeping & General Cleanliness (40%)"),
                        SizedBox(height:10),
                        Text("General Evironment Cleanliness"),
                        LabeledCheckbox(
                            label: ("Adequate and regular pest control.(	Pest control record.)"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[0],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[0] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Goods and equipment are within shop boundary."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[1],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[1] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Store display/ Shop front is neat and tidy."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[2],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[2] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Work/ serving area is neat, clean and free of spillage."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[3],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[3] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Uncluttered circulation space free of refuse/ furniture."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[4],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[4] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Fixtures and fittings including shelves, cupboards and drawers are clean and dry and in a good state."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[5],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[5] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Ceiling/ ceiling boards are free from stains/ dust with no gaps."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[6],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[6] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Fans and air-con units are in proper working order and clean and free from dust. Proper maintenance and routine cleaning are carried out regularly."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[7],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[7] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Equipment is clean, in good condition and serviced.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[8],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[8] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Surfaces, walls and ceilings within customer areas are dry and clean."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[9],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[9] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Floor within customer areas is clean and dry."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[10],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[10] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Waste is properly managed and disposed."
                                "(	Waste bins are not over-filled. )"
                                "(	Waste Management: Proper disposal of general waste.)"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: houseKeepingAndGeneralCleanliness[11],
                            onChanged: (bool newValue){
                              setState(() {
                                houseKeepingAndGeneralCleanliness[11] = newValue;
                                houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Score: $houseKeepingAndGeneralCleanlinessScore"),
                        SizedBox(height:10),
                        SizedBox(height:10),

                        //3. Workplace Safety & Health (40%)
                        Text("3. Workplace Safety & Health (40%)"),
                        SizedBox(height:10),
                        Text("General Safety"),
                        LabeledCheckbox(
                            label: ("MSDS for all industrial chemicals are available and up to date."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[0],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[0] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Proper chemicals storage."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[1],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[1] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("All detergent and bottles containing liquids are labelled appropriately."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[2],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[2] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("All personnel to wear safety shoes and safety attire where necessary."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[3],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[3] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Knives and sharp objects are kept at a safe place."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[4],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[4] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Area under the sink should not be cluttered with items other than washing agents."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[5],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[5] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Delivery personnel do not stack goods above the shoulder level."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[6],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[6] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Stacking of goods does not exceed 600mm from the ceiling and heavy items at the bottom, light items on top."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[7],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[7] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Proper signage/ label (fire, hazards, warnings, food stuff) and Exit signs in working order."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[8],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[8] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Fire & Emergency Safety"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Fire extinguishers access is unobstructed; Fire extinguishers are not expired and employees know how to use them."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[9],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[9] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Escape route and exits are unobstructed."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[10],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[10] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("First aid box is available and well-equipped."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[11],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[11] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Electrical Safety"),
                        SizedBox(height:10),
                        LabeledCheckbox(
                            label: ("Electrical sockets are not overloaded – one plug to one socket."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[12],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[12] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Plugs and cords are intact and free from exposure/ tension with PSB safety mark."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[13],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[13] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Power points that are in close proximity to flammable and/or water sources are installed with a plastic cover.	"),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[14],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[14] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        LabeledCheckbox(
                            label: ("Electrical panels / DBs are covered."),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: workplaceSafetyAndHealth[15],
                            onChanged: (bool newValue){
                              setState(() {
                                workplaceSafetyAndHealth[15] = newValue;
                                workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + workplaceSafetyAndHealthScore)/34) * 100).round();
                              });
                            }
                        ),
                        Text("Score: $workplaceSafetyAndHealthScore"),

                        //TODO: Add total score
                        Text("Total Score: %$totalScore",
                            style : TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height:10),

                        //display warning if totalscore<95
                        Visibility(
                            visible: checkWarning(),
                            child:
                            Text("WARNING: Tenant score is currently less than 95%",
                                style : TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                        ),

                        ElevatedButton(
                            onPressed: submitChecklist,
                            child:Text("Submit checklist")
                        )
                      ],
                    )
                  ],
                )
            )
          ),

    );
  }

  //check if it is less than 95%
  bool checkWarning() {
    if (totalScore < 95){
      return true;
    }
    else{
      return false;
    }
  }


  void submitChecklist() async{
    CollectionReference collection = FirebaseFirestore.instance.collection("institution").doc(staff['institution']).collection("tenant").doc(tenantName)
        .collection("auditChecklist");
    while(true) {
      DocumentSnapshot docSnap = await collection.doc(todayDate.toString()).get();
      if (docSnap.exists) {
        todayDate += '-2';
      } else {
        break;
      }
    }
    try{
      firestoreInstance.collection('institution').doc(staff['institution']).collection("tenant")
          .doc(tenantName).collection("auditChecklist").doc(todayDate).set({
        "date" : todayDate,
        "comments" : comment,
        "auditor" : staff['name'],
        "warning" : checkWarning(),
        "professionalismAndStaffHygiene" : professionalismAndStaffHygiene,
        "professionalismAndStaffHygieneScore" : professionalismAndStaffHygieneScore,
        "houseKeepingAndGeneralCleanliness" : houseKeepingAndGeneralCleanliness,
        "houseKeepingAndGeneralCleanlinessScore" : houseKeepingAndGeneralCleanlinessScore,
        "workplaceSafetyAndHealth" : workplaceSafetyAndHealth,
        "workplaceSafetyAndHealthScore" : workplaceSafetyAndHealthScore,
        "totalScore" : totalScore,
      });
      Toast.show("Successfully submitted checklist", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffHome(user: user)));

    }catch(e) {print(e);}

  }
}

int getElements(List<bool> list){
  int count = 0;

  for (int i = 0; i < list.length; i++){
    if(list[i] == true){
      count++;
    }
  }
  return count;

}