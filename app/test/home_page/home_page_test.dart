import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/reusableWidgets/display_main_movie/display_movie_rating.dart';
import 'package:project/reusableWidgets/display_main_movie/display_movie_release.dart';
import 'package:project/reusableWidgets/display_main_movie/display_movie_title.dart';
import 'package:project/reusableWidgets/display_main_movie/display_poster.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {

  group('Tests for some of the fuctions written', () {
    testWidgets('Test DisplayMovieRating widget', (WidgetTester tester) async {
      // Create the widget
      final movieRating = '8.5';
      final widget = DisplayMovieRating(movieRating: movieRating);

      // Build the widget tree
      await tester.pumpWidget(MaterialApp(home: widget));

      // Find the Text widget and verify its content
      final textWidget = find.text(movieRating);
      expect(textWidget, findsOneWidget);
    });

    testWidgets('Test DisplayMovieTitle widget', (WidgetTester tester) async {
      // Create the widget
      final movieTitle = 'Noddy';
      final widget = DisplayMovieRating(movieRating: movieTitle);

      // Build the widget tree
      await tester.pumpWidget(MaterialApp(home: widget));

      // Find the Text widget and verify its content
      final textWidget = find.text(movieTitle);
      expect(textWidget, findsOneWidget);
    });

    testWidgets('Test DisplayMovieRelease widget', (WidgetTester tester) async {
      // Create the widget
      final movieRelease = '1996';
      final widget = Flex(
        direction: Axis.horizontal,
        children: [
          DisplayMovieRelease(movieRelease: movieRelease),
        ],
      );

      // Build the widget tree
      await tester.pumpWidget(MaterialApp(home: widget));

      // Find the Text widget and verify its content
      final textWidget = find.text(movieRelease);
      expect(textWidget, findsOneWidget);
    });



    testWidgets('Test DisplayMoviePoster', (WidgetTester tester) async {
      const moviePath = 'assets/logo.png';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DisplayMoviePoster(moviePath: moviePath, test: true),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final containerWidget = tester.widget<Container>(containerFinder);

      expect(containerWidget.decoration, equals(BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/logo.png'),
          fit: BoxFit.cover,
        ),
      )));
    });

  });

/*
  group('Test swiping feature', ()
  {
    testWidgets('swipe right should switch the movie in display', (
        WidgetTester tester) async {

      // Build the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: MyHomePage(
              email: 'a@gmail.com', username: 'admin', password: '123456'),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('The Godfather'), findsOneWidget);
      expect(find.text('The Shawshank Redemption'), findsNothing);

      // Swipe right
      final centerWidgetFinder = find.byType(GestureDetector);
      await tester.fling(centerWidgetFinder, const Offset(-200, 0), 1000);
      await tester.pumpAndSettle();

      // Get the new movie title
      expect(find.text('The Godfather'), findsNothing);
      expect(find.text('The Shawshank Redemption'), findsOneWidget);
    });
  });
    

  /*
    group('Tests if animation plays when loading the app', () {

      testWidgets('CircularProgressIndicator is shown when displayMovies is empty', (WidgetTester tester) async {
        // Build the widget tree.
        await tester.pumpWidget(
            MaterialApp(
              home: MyHomePage(email: 'a@gmail.com', username: 'admin', password: '123456', displayMovies: []),
        ));

        // Check if CircularProgressIndicator is shown.
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

   */

 */
}

