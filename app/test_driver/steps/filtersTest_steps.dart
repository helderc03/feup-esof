import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class SeeMoviePageStep extends And1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String expectedPage) async {
    final homePageFinder = find.byValueKey(expectedPage);
    await Future.delayed(Duration(seconds: 6));
    bool isHomePageVisible = await FlutterDriverUtils.isPresent(world.driver, homePageFinder);
    expect(isHomePageVisible, true);
  }

  @override
  RegExp get pattern => RegExp(r"I see {string}");
}

class PressFilterButtonStep extends And1WithWorld<String, FlutterWorld> {
  static String initialMovieTitle = '';
  @override
  Future<void> executeStep(String Filter) async {
// TODO: implement executeStep
    final initialTitleFinder = find.byValueKey('movieTitle');
    final initialTitle = await FlutterDriverUtils.getText( world.driver!, initialTitleFinder);
    initialMovieTitle = initialTitle;
    final filterFinder = find.byValueKey(Filter);
    await FlutterDriverUtils.tap(world.driver, filterFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I press {string}");
}

class VerifyDifferentMoviesShown extends ThenWithWorld<FlutterWorld> {

  @override
  Future<void> executeStep() async {

    final afterPressTitleFinder = find.byValueKey('movieTitle');
    final afterPressTitle = await FlutterDriverUtils.getText(world.driver!,afterPressTitleFinder);

    final areDifferent = (PressFilterButtonStep.initialMovieTitle != afterPressTitle);
    expect(areDifferent, true);
  }
  @override
  RegExp get pattern => RegExp(r"different movies should show up on my screen");
}

