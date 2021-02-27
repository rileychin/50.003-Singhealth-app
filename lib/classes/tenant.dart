import 'package:singhealth_app/classes/person.dart';

class Tenant extends Person {
  String position, institution;
  Tenant(name, email, id, position, institution) : super(name, email, id) {
    this.position = position;
    this.institution = institution;
  }
}
