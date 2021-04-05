import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/classes/tenant.dart';

void main(){

  test("Given staff When getFields is called Then returns fields", () async{
    //ARRANGE
    Tenant tenant = new Tenant("riley","riley@test.com","123456","Manager","CGH","Kopitiam");

    //ACT


    //ASSERT
    expect(tenant.getInstitution(),"CGH");
    expect(tenant.getName(),"riley");
    expect(tenant.getEmail(),"riley@test.com");
    expect(tenant.getId(),"123456");
    expect(tenant.getPosition(),"Manager");
    expect(tenant.getShopName(),"Kopitiam");
  });
}