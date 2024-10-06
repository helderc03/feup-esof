import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/create_account.dart';

void main() {
  /* tests only for the widgets but not working due to the firebase exception, still needs work on that
  group('CreateAccountPage', () {
    testWidgets('should show email, username, password fields', (
        WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateAccountPage()));

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets(
        'should show create account button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateAccountPage()));

      expect(find.widgetWithText(ElevatedButton, 'Create Account'),
          findsOneWidget);
    });


  });

   */
}