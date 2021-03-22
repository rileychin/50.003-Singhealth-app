import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:singhealth_app/Pages/staffHome.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';
import 'package:toast/toast.dart';

class StaffSubmitFnBAuditChecklist extends StatefulWidget {

  final User user;
  final dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;

  final String tenantName;
  final DocumentReference tenantReference;

  StaffSubmitFnBAuditChecklist({
    Key key,
    this.user,
    this.staff,
    this.tenantName,
    this.tenantReference}) : super(key: key);

  @override
  _StaffSubmitFnBAuditChecklistState createState() => _StaffSubmitFnBAuditChecklistState(user,staff,tenantName,tenantReference);

}

class _StaffSubmitFnBAuditChecklistState extends State<StaffSubmitFnBAuditChecklist> {

  User user;
  dynamic staff;
  final firestoreInstance = FirebaseFirestore.instance;
  String tenantName;
  DocumentReference tenantReference;

  //audit details
  String comment;
  String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  //Scores lists and total score
  List<bool> professionalismAndStaffHygiene = new List.filled(13,false);
  int professionalismAndStaffHygieneScore = 0;

  List<bool> houseKeepingAndGeneralCleanliness = new List.filled(17,false);
  int houseKeepingAndGeneralCleanlinessScore = 0;

  List<bool> foodHygiene = new List.filled(37,false);
  int foodHygieneScore = 0;

  List<bool> healthierChoice = new List.filled(11,false);
  int healthierChoiceScore = 0;

  List<bool> workplaceSafetyAndHealth = new List.filled(18,false);
  int workplaceSafetyAndHealthScore = 0;

  int totalScore = 0;
  //convert total score to percentage
  // totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + workplaceSafetyAndHealthScore)/96) * 100).round();

  _StaffSubmitFnBAuditChecklistState(user,staff,tenantName,tenantReference){
    this.user = user;
    this.staff = staff;
    this.tenantName = tenantName;
    this.tenantReference = tenantReference;
  }

  get _localPath => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Submit FnB Audit Checklist'),
      ),
      body:
          SingleChildScrollView(
              child: Align(
                  alignment: Alignment.center,
                  child:
                  //main column
                  Column(
                    children: <Widget>[
                      //standard details
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
                          children:<Widget>[
                            //Profession and staff hygiene
                            //Professionalism & Staff hygiene (10%)
                            Text("1. Professionalism & Staff Hygiene (10%)", textAlign: TextAlign.left),
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
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
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
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
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
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Staff Hygiene"),
                            LabeledCheckbox(
                                label: ("Staff who are unfit for work due to illness should not report to work)."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[3],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[3] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Staff who are fit for work but suffering from the lingering effects of a cough and/or cold should cover their mouths with a surgical mask."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[4],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[4] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Clean clothes/uniform or aprons are worn during food preparation and food service."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[5],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[5] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Hair is kept tidy (long hair must be tied up) and covered with clean caps or hair nets where appropriate."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[6],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[6] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Sores, wounds or cuts on hands, if any, are covered with waterproof and brightly-coloured plaster."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[7],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[7] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Hands are washed thoroughly with soap and water, frequently and at appropriate times.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[8],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[8] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Fingernails are short, clean, unpolished and without nail accessories.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[9],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[9] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("No wrist watches/ rings or other hand jewellery (with exception of wedding ring) is worn by staff handling food."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[10],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[10] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food is handled with clean utensils and gloves. "),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[11],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[11] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Disposable gloves are changed regularly and/ or in between tasks. (	Staff do not handle cash with gloved hands.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: professionalismAndStaffHygiene[12],
                                onChanged: (bool newValue){
                                  setState(() {
                                    professionalismAndStaffHygiene[12] = newValue;
                                    professionalismAndStaffHygieneScore = getElements(professionalismAndStaffHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Score: $professionalismAndStaffHygieneScore",
                            style: TextStyle(color: Colors.green)),

                            //2. Housekeeping & General Cleanliness (20%)
                            Text("2. Housekeeping & General Cleanliness (20%)", textAlign: TextAlign.left),

                            //General Environment Cleanliness
                            Text("General Environment Cleanliness"),
                            SizedBox(height: 10),

                            LabeledCheckbox(
                                label: ("Cleaning and maintenance records for equipment, ventilation and exhaust system."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[0],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[0] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Adequate and regular pest control.(	Pest control record.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[1],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[1] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Goods and equipment are within shop boundary."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[2],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[2] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Store display/ Shop front is neat and tidy."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[3],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[3] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Work/ serving area is neat, clean and free of spillage."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[4],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[4] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Uncluttered circulation space free of refuse/ furniture."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[5],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[5] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Tables are cleared promptly within 10 minutes."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[6],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[6] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Fixtures and fittings including shelves, cupboards and drawers are clean and dry, free from pests, and in a good state."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[7],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[7] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Ceiling/ ceiling boards are free from stains/ dust with no gaps.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[8],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[8] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Fans and air-con units are in proper working order and clean and free from dust. Proper maintenance and routine cleaning are carried out regularly.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[9],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[9] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Equipment, exhaust hood, crockery and utensils are clean, in good condition and serviced."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[10],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[10] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Surfaces, walls and ceilings within customer areas are dry and clean."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[11],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[11] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Floor within customer areas is clean, dry and non-greasy."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[12],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[12] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Waste bins are properly lined with plastic bags and covered at all times.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[13],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[13] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Adequate number of covered waste pedal bins are available and waste is properly managed and disposed."
                                    "(	Waste bins are not over-filled. )"
                                    "(	Waste Management: Proper disposal of food stuff and waste.)"
                                    "(	Waste is properly bagged before disposing it at the waste disposal area/ bin centre.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[14],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[14] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),

                            //Hand Hygiene Facilities
                            Text("Hand Hygiene Facilities"),

                            LabeledCheckbox(
                                label: ("Hand washing facilities are easily accessible, in good working condition and soap is provided."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[15],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[15] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Adequate facilities for hand hygiene are available including liquid soap and disposable hand towels."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: houseKeepingAndGeneralCleanliness[16],
                                onChanged: (bool newValue){
                                  setState(() {
                                    houseKeepingAndGeneralCleanliness[16] = newValue;
                                    houseKeepingAndGeneralCleanlinessScore = getElements(houseKeepingAndGeneralCleanliness);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Score: $houseKeepingAndGeneralCleanlinessScore",
                                style: TextStyle(color: Colors.green)),
                            SizedBox(height:10),


                            //3. Food Hygiene (35%)
                            Text("3. Food Hygiene (35%)"),
                            SizedBox(height:10),
                            Text("Storage & Preparation of Food"),
                            LabeledCheckbox(
                                label: ("Food is stored in appropriate conditions and at an appropriate temperature.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[0],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[0] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food and non-food are clearly segregated.(	Non-food items (e.g. insecticides, detergents and other chemicals) are not stored together with the food items.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[1],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[1] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food is not placed near sources of contamination."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[2],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[2] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Storage of food does not invite pest infestation."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[3],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[3] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Dry goods (e.g. canned food and drinks) and other food items are stored neatly on shelves, off the floor and away from walls.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[4],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[4] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Proper stock rotation system such as the First-Expired-First-Out (FEFO) system is used for inventory management."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[5],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[5] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food is protected from contamination; packaging is intact and no products are found with signs of spoilage."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[6],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[6] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Ice machine is clean and well maintained. (	Only ice is stored in the ice machine to prevent contamination of the ice.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[7],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[7] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Scoop for ice is stored outside the ice machine in a dedicated container."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[8],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[8] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food supplied is clean and not expired."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[9],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[9] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Clear labelling of date of date of preparation/ manufacture/ expiry on all food containers/packaging."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[10],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[10] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Cooked food is properly covered to prevent cross-contamination."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[11],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[11] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Proper work flow and segregation of areas to prevent cross-contamination between raw and cooked/ ready-to-eat food areas."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[12],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[12] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Proper separation of cooked food/ ready-to-eat food, raw meat, seafood and vegetable to prevent cross-contamination."
                                    "(	E.g. Different chopping boards, knives and other utensils are used for cooked/ ready-to-eat and raw food.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[13],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[13] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Frozen food is thawed in chiller, microwave or under running water."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[14],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[14] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Ingredients used are clean and washed thoroughly before cooking."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[15],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[15] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("All cooking ingredient (e.g. cooking oil, sauces) are properly covered in proper containers and properly labelled, indicating the content and date of expiry."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[16],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[16] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("All sauces are stored at appropriate condition & temperature."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[17],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[17] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Cooking oil is not used for more than 1 day."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[18],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[18] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Cooking oil is properly stored with a cover."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[19],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[19] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Perishable food is stored in the fridge."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[20],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[20] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Raw food and cooked food/ ready to serve food are clearly segregated. "
                                    "(	Cold and/ or hot holding units are clean and well maintained.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[21],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[21] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore  + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food preparation area is free of bird and animal (e.g. dog or cat).	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[22],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[22] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food preparation area is clean, free of pests and in good state of repair."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[23],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[23] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food is not prepared on the floor, near drain or near/ in toilet."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[24],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[24] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Personal belongings are kept separately in the staff locker area or cabinet, away from the food storage and preparation area."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[25],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[25] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),

                            //Storage of Food in Refrigerator/Warmer
                            Text("Storage of Food in Refrigerator/ Warmer"),
                            SizedBox(height:10),

                            LabeledCheckbox(
                                label: ("Daily Temperature Log for food storage units (freezers, chillers, warmers, steamers, ovens) using independent thermometer, etc. is maintained for inspection from time to time."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[26],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[26] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food storage units (freezers, chillers, warmers, steamers, ovens) are kept clean and well maintained. All rubber gaskets of refrigerators / warmers are free from defect, dirt and mould."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[27],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[27] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food storage units are not overstocked to allow good air circulation.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[28],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[28] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("For walk-in freezers and chillers, food items are stored neatly on shelves and off the floor."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[29],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[29] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Frozen food is stored at a temperature of not more than -12°C.(	Freezer’s temperature: < -12°C)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[30],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[30] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Chilled food is stored at a temperature of not more than 4°C.(	Chiller’s temperature: 0°C ~ 4°C)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[31],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[31] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Hot food are held above 60°C."
                                    "(	Food warmer’s temperature: > 60°C)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[32],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[32] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Perishable food is stored at a temperature of not more than 4°C.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[33],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[33] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Dairy products are stored at a temperature of not more than 7°C."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[34],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[34] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Cooked/ ready-to-eat food are stored above raw food.	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[35],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[35] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Food items are properly wrapped/covered in proper containers and protected from contamination."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: foodHygiene[36],
                                onChanged: (bool newValue){
                                  setState(() {
                                    foodHygiene[36] = newValue;
                                    foodHygieneScore = getElements(foodHygiene);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Score: $foodHygieneScore",
                                style: TextStyle(color: Colors.green)),
                            SizedBox(height: 10),


                            //4. Healthier Choice in line with HPB’s Healthy Eating’s Initiative (15%)
                            Text('4. Healthier Choice in line with HPB’s Healthy Eating’s Initiative (15%)'),
                            SizedBox(height:10),
                            Text("Food"),

                            LabeledCheckbox(
                                label: ("Min. no. of healthier variety of food items per stall.	"
                                    "(Lease Term:50% of food items.)"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[0],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[0] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Label caloric count of healthier options."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[1],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[1] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Include HPB’s Identifiers beside healthier options."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[2],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[2] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Use of healthier cooking oils."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[3],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[3] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Offer wholemeal/ whole-grain option."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[4],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[4] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Healthier option food sold at lower price than regular items."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[5],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[5] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Limit deep-fried and pre-deep fried food items sold (≤ 20% deep-fried items). 	"),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[6],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[6] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Beverage"),
                            SizedBox(height:10),

                            LabeledCheckbox(
                                label: ("No sugar / Lower-sugar brewed beverage offerings according to guidelines."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[7],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[7] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Healthier option beverages sold at lower price than regular items."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[8],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[8] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Label caloric count of healthier options."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[9],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[9] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Limit sugar content on commercially-prepared sweetened beverages.(≥ 70% commercially-prepared sweetened beverages sold to have HCS) "),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: healthierChoice[10],
                                onChanged: (bool newValue){
                                  setState(() {
                                    healthierChoice[10] = newValue;
                                    healthierChoiceScore = getElements(healthierChoice);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Score: $healthierChoiceScore",
                                style: TextStyle(color: Colors.green)),
                            SizedBox(height:10),

                            //5. Workplace Safety & Health (20%)
                            Text("5. Workplace Safety & Health (20%)"),
                            SizedBox(height:10),
                            Text("General Safety	"),

                            LabeledCheckbox(
                                label: ("All food handlers have Basic Food Hygiene certificate and a valid Refresher Food Hygiene certificate (if applicable)."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[0],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[0] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("MSDS for all industrial chemicals are available and up to date."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[1],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[1] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Proper chemicals storage."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[2],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[2] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("All detergent and bottles containing liquids are labelled appropriately."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[3],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[3] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("All personnel to wear safety shoes and safety attire where necessary."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[4],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[4] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Knives and sharp objects are kept at a safe place."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[5],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[5] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Area under the sink should not be cluttered with items other than washing agents."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[6],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[6] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Delivery personnel do not stack goods above the shoulder level."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[7],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[7] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Stacking of goods does not exceed 600mm from the ceiling and heavy items at the bottom, light items on top."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[8],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[8] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Proper signage/ label (fire, hazards, warnings, food stuff) and Exit signs in working order."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[9],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[9] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Equipment, crockery and utensils are not chipped, broken or cracked."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[10],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[10] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Fire & Emergency Safety"),
                            SizedBox(height:10),

                            LabeledCheckbox(
                                label: ("Fire extinguishers access is unobstructed; Fire extinguishers are not expired and employees know how to use them."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[11],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[11] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Escape route and exits are unobstructed."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[12],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[12] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("First aid box is available and well-equipped."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[13],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[13] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Electrical Safety"),
                            SizedBox(height:10),
                            LabeledCheckbox(
                                label: ("Electrical sockets are not overloaded – one plug to one socket."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[14],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[14] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Plugs and cords are intact and free from exposure/ tension with PSB safety mark."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[15],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[15] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Power points that are in close proximity to flammable and/or water sources are installed with a plastic cover."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[16],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[16] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            LabeledCheckbox(
                                label: ("Electrical panels / DBs are covered."),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                value: workplaceSafetyAndHealth[17],
                                onChanged: (bool newValue){
                                  setState(() {
                                    workplaceSafetyAndHealth[17] = newValue;
                                    workplaceSafetyAndHealthScore = getElements(workplaceSafetyAndHealth);
                                    totalScore = (((professionalismAndStaffHygieneScore + houseKeepingAndGeneralCleanlinessScore + foodHygieneScore + healthierChoiceScore + workplaceSafetyAndHealthScore)/96) * 100).round();
                                  });
                                }
                            ),
                            Text("Score: $workplaceSafetyAndHealthScore",
                                style: TextStyle(color: Colors.green)),

                            //TODO: Add total score
                            Text("Total Score: %$totalScore",
                                style : TextStyle(fontWeight: FontWeight.bold,color: Colors.lime)),
                            SizedBox(height:10),

                            //display warning if totalscore<95
                            Visibility(
                              visible: checkWarning(),
                              child:
                                Text("WARNING: Tenant score is currently less than 95%",
                                    style : TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.red))
                            ),

                            ElevatedButton(
                              onPressed: submitChecklist,
                              child:Text("Submit checklist")
                            ),


                          ]
                      ),

                    ],
                  )
              )
          )


    );
  }

  //TODO: Add submit checklist button, navigate to
  Future<void> submitChecklist() async {
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
      //add to firestore

    try{
      FirebaseFirestore.instance.collection('institution').doc(staff['institution']).collection("tenant")
          .doc(tenantName).collection("auditChecklist").doc(todayDate).set({
        "date" : todayDate,
        "comments" : comment,
        "auditor" : staff['name'],
        "warning" : checkWarning(),
        "professionalismAndStaffHygiene" : professionalismAndStaffHygiene,
        "professionalismAndStaffHygieneScore" : professionalismAndStaffHygieneScore,
        "houseKeepingAndGeneralCleanliness" : houseKeepingAndGeneralCleanliness,
        "houseKeepingAndGeneralCleanlinessScore" : houseKeepingAndGeneralCleanlinessScore,
        "foodHygiene" : foodHygiene,
        "foodHygieneScore" : foodHygieneScore,
        "healthierChoice" : healthierChoice,
        "healthierChoiceScore" : healthierChoiceScore,
        "workplaceSafetyAndHealth" : workplaceSafetyAndHealth,
        "workplaceSafetyAndHealthScore" : workplaceSafetyAndHealthScore,
        "totalScore" : totalScore
      });
      Toast.show("Successfully submitted checklist", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> StaffHome(user: user)));
    } catch(e){
        print(e);
    }



  }

  bool checkWarning() {
    if (totalScore < 95){
      return true;
    }
    else{
      return false;
    }
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
