import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/classes/staff.dart';

void main(){

  test("Given staff When getFields is called Then returns fields", () async{
    //ARRANGE
    Staff staff = new Staff("riley","riley@test.com","123456","CGH");

    //ACT


    //ASSERT
    expect(staff.getInstitution(),"CGH");
    expect(staff.getName(),"riley");
    expect(staff.getEmail(),"riley@test.com");
    expect(staff.getId(),"123456");
  });
}