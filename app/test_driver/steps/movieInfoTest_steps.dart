import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ClickPosterStep extends When1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String moviePoster ) async {
    await Future.delayed(Duration(seconds: 4));
    final moviePosterFinder = find.byValueKey(moviePoster);
    bool isMoviePosterVisible = await FlutterDriverUtils.isPresent(world.driver, moviePosterFinder);
    expect(isMoviePosterVisible, true);
    await FlutterDriverUtils.tap(world.driver, moviePosterFinder);
  }

  @override
  RegExp get pattern => RegExp(r"I click on {string}");
}

class CheckRatingStep extends When1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String movieRating ) async {
    final movieRatingFinder = find.byValueKey(movieRating);
    bool isMovieRatingVisible = await FlutterDriverUtils.isPresent(world.driver, movieRatingFinder);
    expect(isMovieRatingVisible, true);
  }

  @override
  RegExp get pattern => RegExp(r"I should see the {string}");
}

