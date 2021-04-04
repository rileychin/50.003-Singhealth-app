import 'package:singhealth_app/classes/person.dart';

class Tenant extends Person {
  String position, institution, shopName;
  Tenant(name, email, id, position, institution, shopName) : super(name, email, id) {
    this.position = position;
    this.institution = institution;
    this.shopName = shopName;
  }

  String getPosition() {
    return this.position;
  }

  String getInstitution() {
    return this.institution;
  }

  String getShopName(){
    return this.shopName;
  }

}