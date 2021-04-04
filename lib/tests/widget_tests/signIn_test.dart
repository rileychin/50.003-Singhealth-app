import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseUser extends Mock implements User {}

//find widgets for
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();

  Widget testWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: new LoginPage()),
  );

  //finds tests for widgets
  testWidgets('Given Signin When page is loaded Then display textfields', (WidgetTester tester) async {
    //verify that widgets have been found
    await tester.pumpWidget(testWidget);

    final emailText =  find.text("Email");
    final passwordText = find.text("Password");

    expect(emailText,findsOneWidget);
    expect(passwordText,findsOneWidget);

  });

  //test VALID login
  testWidgets("Given Signin When valid email and password entered Then login to appropriate page", (WidgetTester tester) async{

    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final emailText =  find.byKey(ValueKey("email"));
    final passwordText = find.byKey(ValueKey("password"));
    final signInButton = find.byKey(ValueKey("sign_in"));

    await tester.enterText(emailText, "admin@test.com");

    await tester.enterText(passwordText,"123456");

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));
    expect(find.text("Your password needs to be at least 6 characters"),findsNothing);
    expect(find.text("Please enter valid email format"),findsNothing);

  });

  //test INVALID login (password)
  testWidgets("Given Signin When invalid email and valid password entered Then no login", (WidgetTester tester) async{

    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final emailText =  find.byKey(ValueKey("email"));
    final passwordText = find.byKey(ValueKey("password"));
    final signInButton = find.byKey(ValueKey("sign_in"));

    await tester.enterText(emailText, "admin@test.com");

    await tester.enterText(passwordText,"123");

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));
    expect(find.text("Your password needs to be at least 6 characters"),findsOneWidget);
    expect(find.text("Please enter valid email format"),findsNothing);

  });

  //test INVALID login (email)
  testWidgets("Given Signin When invalid email and valid password entered Then no login", (WidgetTester tester) async{

    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final emailText =  find.byKey(ValueKey("email"));
    final passwordText = find.byKey(ValueKey("password"));
    final signInButton = find.byKey(ValueKey("sign_in"));

    await tester.enterText(emailText, "admin122321");

    await tester.enterText(passwordText,"123456");

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));
    expect(find.text("Your password needs to be at least 6 characters"),findsNothing);
    expect(find.text("Please enter valid email format"),findsOneWidget);

  });

  //test INVALID login (email and password)
  testWidgets("Given Signin When invalid email and invalid password entered Then no login", (WidgetTester tester) async{

    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final emailText =  find.byKey(ValueKey("email"));
    final passwordText = find.byKey(ValueKey("password"));
    final signInButton = find.byKey(ValueKey("sign_in"));

    await tester.enterText(emailText, "admin122321");

    await tester.enterText(passwordText,"1");

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));
    expect(find.text("Your password needs to be at least 6 characters"),findsOneWidget);
    expect(find.text("Please enter valid email format"),findsOneWidget);

  });
}