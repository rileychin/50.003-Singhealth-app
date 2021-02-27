import 'package:singhealth_app/classes/person.dart';

class Staff extends Person{

  String institution;

  Staff(name,email,id,institution) : super(name,email,id){
    this.institution = institution;
  }

}