import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';
import 'package:singhealth_app/setup/welcome.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

//find widgets
void main(){
  Widget testWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: new SignUp()),
  );

  //test find widgets general
  testWidgets("Given signUp When signUp is loaded Then display all common widgets",(WidgetTester tester) async{
    await tester.pumpWidget(testWidget);

    final name = find.byKey(ValueKey("name"));
    final email = find.byKey(ValueKey("email"));
    final password = find.byKey(ValueKey("password"));
    final institution = find.byKey(ValueKey("institution"));

    final admin = find.byKey(ValueKey("admin"));
    final staff = find.byKey(ValueKey("staff"));
    final tenant = find.byKey(ValueKey("tenant"));

    expect(name, findsOneWidget);
    expect(email, findsOneWidget);
    expect(password, findsOneWidget);
    expect(institution, findsOneWidget);

    expect(admin, findsOneWidget);
    expect(staff, findsOneWidget);
    expect(tenant, findsOneWidget);

    //hidden form fields
    final secret = find.byKey(ValueKey("secret"));
    final shopName = find.byKey(ValueKey("shopName"));
    final position = find.byKey(ValueKey("position"));

    expect(secret,findsNothing);
    expect(shopName,findsNothing);
    expect(position,findsNothing);
  });

  //test find widgets for admin
  testWidgets("Given signUp When signUp is loaded Then display all common widgets",(WidgetTester tester) async{
    await tester.pumpWidget(testWidget);
    final admin = find.byKey(ValueKey("admin"));

    await tester.tap(admin);
    await tester.pump();

    //verify that secret TextFormField appears
    final secret = find.byKey(ValueKey("secret"));
    final shopName = find.byKey(ValueKey("shopName"));
    final position = find.byKey(ValueKey("position"));
    expect(secret,findsOneWidget);
    expect(shopName,findsNothing);
    expect(position,findsNothing);

    //verify that no other field appears
  });
  //test find widgets for staff
  testWidgets("Given signUp When signUp is loaded Then display all common widgets",(WidgetTester tester) async{
    await tester.pumpWidget(testWidget);
    final admin = find.byKey(ValueKey("staff"));

    await tester.tap(admin);
    await tester.pump();

    //verify that secret TextFormField appears
    final secret = find.byKey(ValueKey("secret"));
    final shopName = find.byKey(ValueKey("shopName"));
    final position = find.byKey(ValueKey("position"));
    expect(secret,findsNothing);
    expect(shopName,findsNothing);
    expect(position,findsNothing);

    //verify that no other field appears
  });

  //test find widgets for tenant
  testWidgets("Given signUp When signUp is loaded Then display all common widgets",(WidgetTester tester) async{
    await tester.pumpWidget(testWidget);
    final admin = find.byKey(ValueKey("tenant"));

    await tester.tap(admin);
    await tester.pump();

    //verify that secret TextFormField appears
    final secret = find.byKey(ValueKey("secret"));
    final shopName = find.byKey(ValueKey("shopName"));
    final position = find.byKey(ValueKey("position"));
    expect(secret,findsNothing);
    expect(shopName,findsOneWidget);
    expect(position,findsOneWidget);

    //verify that no other field appears
  });
}