import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/Pages/adminAddTenant.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseAuthMocks.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

class MockFirestore extends Mock implements FirebaseFirestore{}


void main() {

  dynamic data;
  final instance = MockFirestoreInstance();
  instance.collection("admin").doc("s8vuQ4OeYhOyAmLRK4o3ejXuMnG3").set({
    'email' : "admin@test.com",
    'id' : "s8vuQ4OeYhOyAmLRK4o3ejXuMnG3",
    'institution' : "CGH",
    'name' : "Admin",
  });

  instance.collection("admin").doc("s8vuQ4OeYhOyAmLRK4o3ejXuMnG3").get().then<dynamic>((DocumentSnapshot snapshot){
    data = snapshot.data();
  });

  final user = MockUser(isAnonymous: false,
      uid: "s8vuQ4OeYhOyAmLRK4o3ejXuMnG3",
      email: "admin@test.com",
      displayName: "Admin"
  );

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  //Test valid add tenant details
  testWidgets("", (WidgetTester tester) async{

    //ARRANGE
    await tester.pumpWidget(new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new AdminAddTenant(user: user, admin: data))
    ));

    final tenantName = find.byKey(ValueKey("tenantName"));
    final tenantUnitNumber = find.byKey(ValueKey("tenantUnitNumber"));
    final tenantPhoneNumber = find.byKey(ValueKey("tenantPhoneNumber"));
    final confirmButton = find.byKey(ValueKey("confirmButton"));

    //ACT
    await tester.enterText(tenantName, "KFC");
    await tester.enterText(tenantUnitNumber, "#02-152");
    await tester.enterText(tenantPhoneNumber, "62312273");
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    //ASSERT
    expect(find.text("Please enter a name for the new tenant"),findsNothing);
    expect(find.text("Please enter a unit number"),findsNothing);
    expect(find.text("Please enter a phone number"),findsNothing);
  });

  //test empty tenant name
  testWidgets("", (WidgetTester tester) async{

    //ARRANGE
    await tester.pumpWidget(new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AdminAddTenant(user: user, admin: data))
    ));

    final tenantName = find.byKey(ValueKey("tenantName"));
    final tenantUnitNumber = find.byKey(ValueKey("tenantUnitNumber"));
    final tenantPhoneNumber = find.byKey(ValueKey("tenantPhoneNumber"));
    final confirmButton = find.byKey(ValueKey("confirmButton"));

    //ACT
    await tester.enterText(tenantName, "");
    await tester.enterText(tenantUnitNumber, "#02-152");
    await tester.enterText(tenantPhoneNumber, "62312273");
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    //ASSERT
    expect(find.text("Please enter a name for the new tenant"),findsOneWidget);
    expect(find.text("Please enter a unit number"),findsNothing);
    expect(find.text("Please enter a phone number"),findsNothing);
  });

  //test empty unit number
  testWidgets("", (WidgetTester tester) async{

    //ARRANGE
    await tester.pumpWidget(new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AdminAddTenant(user: user, admin: data))
    ));

    final tenantName = find.byKey(ValueKey("tenantName"));
    final tenantUnitNumber = find.byKey(ValueKey("tenantUnitNumber"));
    final tenantPhoneNumber = find.byKey(ValueKey("tenantPhoneNumber"));
    final confirmButton = find.byKey(ValueKey("confirmButton"));

    //ACT
    await tester.enterText(tenantName, "KFC");
    await tester.enterText(tenantUnitNumber, "");
    await tester.enterText(tenantPhoneNumber, "62312273");
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    //ASSERT
    expect(find.text("Please enter a name for the new tenant"),findsNothing);
    expect(find.text("Please enter a unit number"),findsOneWidget);
    expect(find.text("Please enter a phone number"),findsNothing);
  });

  //test empty phone number
  testWidgets("", (WidgetTester tester) async{

    //ARRANGE
    await tester.pumpWidget(new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AdminAddTenant(user: user, admin: data))
    ));

    final tenantName = find.byKey(ValueKey("tenantName"));
    final tenantUnitNumber = find.byKey(ValueKey("tenantUnitNumber"));
    final tenantPhoneNumber = find.byKey(ValueKey("tenantPhoneNumber"));
    final confirmButton = find.byKey(ValueKey("confirmButton"));

    //ACT
    await tester.enterText(tenantName, "KFC");
    await tester.enterText(tenantUnitNumber, "#02-153");
    await tester.enterText(tenantPhoneNumber, "");
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    //ASSERT
    expect(find.text("Please enter a name for the new tenant"),findsNothing);
    expect(find.text("Please enter a unit number"),findsNothing);
    expect(find.text("Please enter a phone number"),findsOneWidget);
  });
}