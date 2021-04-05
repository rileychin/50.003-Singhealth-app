import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/classes/admin.dart';

void main(){

  test("Given admin When getFields is called Then returns fields", () async{
    //ARRANGE
    Admin admin = new Admin("riley","riley@test.com","123456","CGH");

    //ACT


    //ASSERT
    expect(admin.getInstitution(),"CGH");
    expect(admin.getName(),"riley");
    expect(admin.getEmail(),"riley@test.com");
    expect(admin.getId(),"123456");
  });
}