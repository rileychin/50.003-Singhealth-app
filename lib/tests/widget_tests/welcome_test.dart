import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:singhealth_app/setup/signUp.dart';
import 'package:singhealth_app/setup/welcome.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

//Widget tests tests finding widgets
void main(){

  Widget testWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: new WelcomePage()),
  );

  //test 1
  testWidgets('Given homepage When page loads Then verify buttons', (WidgetTester tester) async {
    //verify that widgets have been found
    await tester.pumpWidget(testWidget);

    final signInButton =  find.byKey(ValueKey("sign_in"));
    final signUpButton = find.byKey(ValueKey("sign_up"));

    expect(signInButton,findsOneWidget);
    expect(signUpButton,findsOneWidget);

  });

  //test 2
  testWidgets('Given signIn When sign in is pressed Then go to signIn page', (WidgetTester tester) async{
    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final signInButton =  find.byKey(ValueKey("sign_in"));

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));

    expect(find.byType(LoginPage),findsOneWidget);
  });

  //test 3
  testWidgets('Given signUp When sign up is pressed Then go to signUp page', (WidgetTester tester) async{
    await tester.pumpWidget(testWidget);
    final mockObserver = MockNavigatorObserver();

    final signUpButton =  find.byKey(ValueKey("sign_up"));

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    verifyNever(mockObserver.didPush(any,any));

    expect(find.byType(SignUp),findsOneWidget);
  });

}