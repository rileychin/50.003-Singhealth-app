import 'package:singhealth_app/classes/person.dart';

class Admin extends Person {

  String institution;

  Admin(name,email,id,institution) : super(name,email,id){
    this.institution = institution;
  }

  String getInstitution(){
    return this.institution;
  }

}