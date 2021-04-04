import 'package:singhealth_app/classes/person.dart';

class Staff extends Person{

  //additional features for features 
  String institution;

  Staff(name,email,id,institution) : super(name,email,id){
    this.institution = institution;
  }

  String getInstitution(){
    return this.institution;
  }

}