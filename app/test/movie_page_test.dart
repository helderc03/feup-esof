import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/reusableWidgets/media_model.dart';
import 'package:project/pages/movie_page.dart';

void main() {
  /* still firebaseException, tests are structured
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('MoviePage displays movie rating', (WidgetTester tester) async {
    // Arrange: Mock movie data
    final mockMovie = MediaModel(
        "My Movie Title", "2022", 4.5, "/path/to/poster.jpg", "A great movie!", 1);

    // Act: Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MoviePage(
          email: 'a@gmail.com',
          password: '123456',
          username: 'admin',
          mediaModel: mockMovie,
        ),
      ),
    );

    // Assert: Find the movie rating text widget
    final ratingTextFinder = find.text('4.5');

    // Check if the movie rating text widget is found and is displayed correctly
    expect(ratingTextFinder, findsOneWidget);
  });

   */
}
