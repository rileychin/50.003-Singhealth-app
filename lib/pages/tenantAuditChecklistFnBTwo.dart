import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singhealth_app/classes/LabeledCheckBox.dart';

class TenantAuditChecklistFnBTwo extends StatefulWidget {

  final User user;
  final dynamic tenant, auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;


  TenantAuditChecklistFnBTwo({
    Key key,
    this.user,
    this.tenant,
    this.auditChecklist}) : super(key: key);

  @override
  _TenantAuditChecklistFnBTwoState createState() => _TenantAuditChecklistFnBTwoState(user,tenant,auditChecklist);
}

class _TenantAuditChecklistFnBTwoState extends State<TenantAuditChecklistFnBTwo> {

  User user;
  dynamic tenant,auditChecklist;
  final firestoreInstance = FirebaseFirestore.instance;


  _TenantAuditChecklistFnBTwoState(user,tenant,auditChecklist){
    this.user = user;
    this.tenant = tenant;
    this.auditChecklist = auditChecklist;
  }

  @override
  Widget build(BuildContext context) {
    if (auditChecklist == null) {return CircularProgressIndicator();}
    return Scaffold(
        appBar: AppBar(
          title: Text('${tenant['shopName']} ${auditChecklist['date']} audit checklist'),
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
                        Text("Date of audit: ${auditChecklist['date']}"),
                        SizedBox(height:10),
                        Text("Auditee: ${tenant['shopName']}"),
                        SizedBox(height:10),
                        Text("Auditor: ${auditChecklist['date']}"),
                        SizedBox(height:10),
                        Text("Comments: ${auditChecklist['comments']}"),
                        SizedBox(height:10),
                      ],
                    ),

                    //Professionalism & Staff hygiene (10%)
                    Column(
                        children:<Widget>[
                          //Profession and staff hygiene
                          Text("1. Professionalism & Staff Hygiene (10%)", textAlign: TextAlign.left),
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
                          LabeledCheckbox(
                              label: ("Staff who are unfit for work due to illness should not report to work)."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][3],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Staff who are fit for work but suffering from the lingering effects of a cough and/or cold should cover their mouths with a surgical mask."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][4],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Clean clothes/uniform or aprons are worn during food preparation and food service."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][5],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Hair is kept tidy (long hair must be tied up) and covered with clean caps or hair nets where appropriate."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][6],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Sores, wounds or cuts on hands, if any, are covered with waterproof and brightly-coloured plaster."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][7],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Hands are washed thoroughly with soap and water, frequently and at appropriate times.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][8],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Fingernails are short, clean, unpolished and without nail accessories.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][9],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("No wrist watches/ rings or other hand jewellery (with exception of wedding ring) is worn by staff handling food."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][10],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food is handled with clean utensils and gloves. "),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][11],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Disposable gloves are changed regularly and/ or in between tasks. (	Staff do not handle cash with gloved hands.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['professionalismAndStaffHygiene'][12],
                              onChanged: null
                          ),
                          Text("Score: ${auditChecklist['professionalismAndStaffHygieneScore']}"),

                          //2. Housekeeping & General Cleanliness (20%)
                          Text("2. Housekeeping & General Cleanliness (20%)", textAlign: TextAlign.left),

                          //General Environment Cleanliness
                          Text("General Environment Cleanliness"),
                          SizedBox(height: 10),

                          LabeledCheckbox(
                              label: ("Cleaning and maintenance records for equipment, ventilation and exhaust system."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][0],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Adequate and regular pest control.(	Pest control record.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][1],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Goods and equipment are within shop boundary."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][2],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Store display/ Shop front is neat and tidy."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][3],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Work/ serving area is neat, clean and free of spillage."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][4],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Uncluttered circulation space free of refuse/ furniture."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][5],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Tables are cleared promptly within 10 minutes."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][6],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Fixtures and fittings including shelves, cupboards and drawers are clean and dry, free from pests, and in a good state."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][7],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Ceiling/ ceiling boards are free from stains/ dust with no gaps.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][8],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Fans and air-con units are in proper working order and clean and free from dust. Proper maintenance and routine cleaning are carried out regularly.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][9],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Equipment, exhaust hood, crockery and utensils are clean, in good condition and serviced."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][10],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Surfaces, walls and ceilings within customer areas are dry and clean."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][11],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Floor within customer areas is clean, dry and non-greasy."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][12],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Waste bins are properly lined with plastic bags and covered at all times.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][13],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Adequate number of covered waste pedal bins are available and waste is properly managed and disposed."
                                  "(	Waste bins are not over-filled. )"
                                  "(	Waste Management: Proper disposal of food stuff and waste.)"
                                  "(	Waste is properly bagged before disposing it at the waste disposal area/ bin centre.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][14],
                              onChanged: null
                          ),

                          //Hand Hygiene Facilities
                          Text("Hand Hygiene Facilities"),

                          LabeledCheckbox(
                              label: ("Hand washing facilities are easily accessible, in good working condition and soap is provided."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][15],
                              onChanged:null
                          ),
                          LabeledCheckbox(
                              label: ("Adequate facilities for hand hygiene are available including liquid soap and disposable hand towels."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['houseKeepingAndGeneralCleanliness'][16],
                              onChanged: null
                          ),
                          Text("Score: ${auditChecklist['houseKeepingAndGeneralCleanlinessScore']}"),
                          SizedBox(height:10),


                          //3. Food Hygiene (35%)
                          Text("3. Food Hygiene (35%)"),
                          SizedBox(height:10),
                          Text("Storage & Preparation of Food"),
                          LabeledCheckbox(
                              label: ("Food is stored in appropriate conditions and at an appropriate temperature.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][0],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food and non-food are clearly segregated.(	Non-food items (e.g. insecticides, detergents and other chemicals) are not stored together with the food items.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][1],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food is not placed near sources of contamination."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][2],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Storage of food does not invite pest infestation."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][3],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Dry goods (e.g. canned food and drinks) and other food items are stored neatly on shelves, off the floor and away from walls.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][4],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Proper stock rotation system such as the First-Expired-First-Out (FEFO) system is used for inventory management."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][5],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food is protected from contamination; packaging is intact and no products are found with signs of spoilage."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][6],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Ice machine is clean and well maintained. (	Only ice is stored in the ice machine to prevent contamination of the ice.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][7],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Scoop for ice is stored outside the ice machine in a dedicated container."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][8],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food supplied is clean and not expired."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][9],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Clear labelling of date of date of preparation/ manufacture/ expiry on all food containers/packaging."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][10],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Cooked food is properly covered to prevent cross-contamination."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][11],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Proper work flow and segregation of areas to prevent cross-contamination between raw and cooked/ ready-to-eat food areas."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][12],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Proper separation of cooked food/ ready-to-eat food, raw meat, seafood and vegetable to prevent cross-contamination."
                                  "(	E.g. Different chopping boards, knives and other utensils are used for cooked/ ready-to-eat and raw food.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][13],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Frozen food is thawed in chiller, microwave or under running water."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][14],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Ingredients used are clean and washed thoroughly before cooking."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][15],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("All cooking ingredient (e.g. cooking oil, sauces) are properly covered in proper containers and properly labelled, indicating the content and date of expiry."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][16],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("All sauces are stored at appropriate condition & temperature."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][17],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Cooking oil is not used for more than 1 day."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][18],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Cooking oil is properly stored with a cover."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][19],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Perishable food is stored in the fridge."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][20],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Raw food and cooked food/ ready to serve food are clearly segregated. "
                                  "(	Cold and/ or hot holding units are clean and well maintained.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][21],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food preparation area is free of bird and animal (e.g. dog or cat).	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][22],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food preparation area is clean, free of pests and in good state of repair."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][23],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food is not prepared on the floor, near drain or near/ in toilet."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][24],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Personal belongings are kept separately in the staff locker area or cabinet, away from the food storage and preparation area."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][25],
                              onChanged: null
                          ),

                          //Storage of Food in Refrigerator/Warmer
                          Text("Storage of Food in Refrigerator/ Warmer"),
                          SizedBox(height:10),

                          LabeledCheckbox(
                              label: ("Daily Temperature Log for food storage units (freezers, chillers, warmers, steamers, ovens) using independent thermometer, etc. is maintained for inspection from time to time."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][26],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food storage units (freezers, chillers, warmers, steamers, ovens) are kept clean and well maintained. All rubber gaskets of refrigerators / warmers are free from defect, dirt and mould."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][27],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food storage units are not overstocked to allow good air circulation.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][28],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("For walk-in freezers and chillers, food items are stored neatly on shelves and off the floor."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][29],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Frozen food is stored at a temperature of not more than -12°C.(	Freezer’s temperature: < -12°C)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][30],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Chilled food is stored at a temperature of not more than 4°C.(	Chiller’s temperature: 0°C ~ 4°C)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][31],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Hot food are held above 60°C."
                                  "(	Food warmer’s temperature: > 60°C)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][32],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Perishable food is stored at a temperature of not more than 4°C.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][33],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Dairy products are stored at a temperature of not more than 7°C."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][34],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Cooked/ ready-to-eat food are stored above raw food.	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][35],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Food items are properly wrapped/covered in proper containers and protected from contamination."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['foodHygiene'][36],
                              onChanged: null
                          ),
                          Text("Score: ${auditChecklist['foodHygieneScore']}"),
                          SizedBox(height: 10),


                          //4. Healthier Choice in line with HPB’s Healthy Eating’s Initiative (15%)
                          Text('4. Healthier Choice in line with HPB’s Healthy Eating’s Initiative (15%)'),
                          SizedBox(height:10),
                          Text("Food"),

                          LabeledCheckbox(
                              label: ("Min. no. of healthier variety of food items per stall.	"
                                  "(Lease Term:50% of food items.)"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][0],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Label caloric count of healthier options."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][1],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Include HPB’s Identifiers beside healthier options."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][2],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Use of healthier cooking oils."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][3],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Offer wholemeal/ whole-grain option."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][4],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Healthier option food sold at lower price than regular items."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][5],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Limit deep-fried and pre-deep fried food items sold (≤ 20% deep-fried items). 	"),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][6],
                              onChanged: null
                          ),
                          Text("Beverage"),
                          SizedBox(height:10),

                          LabeledCheckbox(
                              label: ("No sugar / Lower-sugar brewed beverage offerings according to guidelines."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][7],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Healthier option beverages sold at lower price than regular items."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][8],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Label caloric count of healthier options."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][9],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Limit sugar content on commercially-prepared sweetened beverages.(≥ 70% commercially-prepared sweetened beverages sold to have HCS) "),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['healthierChoice'][10],
                              onChanged: null
                          ),
                          Text("Score: ${auditChecklist['healthierChoiceScore']}"),
                          SizedBox(height:10),

                          //5. Workplace Safety & Health (20%)
                          Text("5. Workplace Safety & Health (20%)"),
                          SizedBox(height:10),
                          Text("General Safety	"),

                          LabeledCheckbox(
                              label: ("All food handlers have Basic Food Hygiene certificate and a valid Refresher Food Hygiene certificate (if applicable)."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][0],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("MSDS for all industrial chemicals are available and up to date."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][1],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Proper chemicals storage."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][2],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("All detergent and bottles containing liquids are labelled appropriately."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][3],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("All personnel to wear safety shoes and safety attire where necessary."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][4],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Knives and sharp objects are kept at a safe place."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][5],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Area under the sink should not be cluttered with items other than washing agents."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][6],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Delivery personnel do not stack goods above the shoulder level."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][7],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Stacking of goods does not exceed 600mm from the ceiling and heavy items at the bottom, light items on top."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][8],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Proper signage/ label (fire, hazards, warnings, food stuff) and Exit signs in working order."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][9],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Equipment, crockery and utensils are not chipped, broken or cracked."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][10],
                              onChanged: null
                          ),
                          Text("Fire & Emergency Safety"),
                          SizedBox(height:10),

                          LabeledCheckbox(
                              label: ("Fire extinguishers access is unobstructed; Fire extinguishers are not expired and employees know how to use them."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][11],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Escape route and exits are unobstructed."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][12],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("First aid box is available and well-equipped."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][13],
                              onChanged: null
                          ),
                          Text("Electrical Safety"),
                          SizedBox(height:10),
                          LabeledCheckbox(
                              label: ("Electrical sockets are not overloaded – one plug to one socket."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][14],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Plugs and cords are intact and free from exposure/ tension with PSB safety mark."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][15],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Power points that are in close proximity to flammable and/or water sources are installed with a plastic cover."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][16],
                              onChanged: null
                          ),
                          LabeledCheckbox(
                              label: ("Electrical panels / DBs are covered."),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              value: auditChecklist['workplaceSafetyAndHealth'][17],
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

                        ]
                    ),

                  ],
                )
            )
        )

    );
  }

  checkWarning() {if (auditChecklist['warning']) return true; else return false;}
}
