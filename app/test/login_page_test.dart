import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/pages/create_account.dart';

void main() {
  // widget testing on login_page, create account btn redirecting not working
  //due to firebase instance needed and can't start from this page.
  group('LoginPage widget testing', () {

    testWidgets('Input fields show hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(
            home: LoginPage(),
      )
      );

      expect(find.text("Email"), findsOneWidget);
      expect(find.text("Password"), findsOneWidget);
    });

    testWidgets('App Icon appears', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, equals(Image.asset('assets/logo.png').image));

    });

    /*
    testWidgets('_createAccountBtn displays "Create now" text and navigates to CreateAccountPage on tap', (WidgetTester tester) async {
      // Build the widget tree
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Find the TextButton widget
      final textButtonFinder = find.widgetWithText(TextButton, "Don't have an account? Create now");
      expect(textButtonFinder, findsOneWidget);

      // Verify that the button text is "Don't have an account? Create now"
      final buttonText = "Don't have an account? Create now";
      final buttonTextWidget = tester.widget<Text>(find.text(buttonText));
      expect(buttonTextWidget.data, equals(buttonText));

      // Tap the TextButton widget
      await tester.tap(textButtonFinder);
      await tester.pumpAndSettle();

      // Verify that the app navigated to the CreateAccountPage
      final createAccountPageFinder = find.byType(CreateAccountPage);
      expect(createAccountPageFinder, findsOneWidget);
    });

     */
  });

}


