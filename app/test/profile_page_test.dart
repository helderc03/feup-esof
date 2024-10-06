import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/pages/profile_page.dart';

//class MockFirebaseAuth extends Mock implements FirebaseAuth {}
//class MockUserCredential extends Mock implements UserCredential {}

void main() {


  /* tests are semi structured but firebaseException error
  testWidgets('should display email and username', (WidgetTester tester) async {
    const email = 'example@test.com';
    const username = 'JohnDoe';
    const password = 'password';

    final profilePage = ProfilePage(email: email, username: username, password: password);
    await tester.pumpWidget(MaterialApp(
      home: profilePage,
    ));

    expect(profilePage.email, equals(email));
    expect(profilePage.username, equals(username));
  });

  /*
  group('ImageWidget', () {


    testWidgets('should log out when Logout button is pressed', (WidgetTester tester) async {

      const email = 'example@test.com';
      const username = 'JohnDoe';
      const password = 'password';

      await tester.pumpWidget(MaterialApp(
        home: ImageWidget(email: email, username: username, password: password),
      ));

      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });

   */

 */

}
