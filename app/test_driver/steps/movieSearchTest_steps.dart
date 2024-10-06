import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class SearchPageCheck
    extends And1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String searchPage) async {
// TODO: implement executeStep
    final SearchPageButton = find.byValueKey("SearchPageIcon");
    await FlutterDriverUtils.tap(world.driver, SearchPageButton);
    final searchPageFinder = find.byValueKey(searchPage);
    bool isSearchPageVisible = await FlutterDriverUtils.isPresent(world.driver, searchPageFinder);
    expect(isSearchPageVisible, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I go to {string}");
}

class InputMovieName
    extends Given2WithWorld<String,String,FlutterWorld> {
  @override
  Future<void> executeStep(String movieName, String searchBar) async {
// TODO: implement executeStep
    final SearchBarFinder = find.byValueKey(searchBar);
    await FlutterDriverUtils.tap(world.driver, SearchBarFinder);
    await FlutterDriverUtils.enterText(world.driver,SearchBarFinder, movieName);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I enter {string} to {string}");
}

class SearchResultShouldShow extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String movieTitle) async {
    final movieTitleFinder = find.text(movieTitle);
    final driver = world.driver as FlutterDriver;

    // Find the movie title in the search results
    final resultFinder = find.descendant(
      of: find.byType('ListView'),
      matching: movieTitleFinder,
    );

    // Wait for the movie title to appear in the search results
    await driver.waitFor(resultFinder);

    final isMovieTitleVisible = await FlutterDriverUtils.isPresent(world.driver, resultFinder);
    expect(isMovieTitleVisible, true);
  }

  @override
  RegExp get pattern => RegExp(r"{string} should show up on the results");
}

