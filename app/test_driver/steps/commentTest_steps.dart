import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:http/http.dart';

class GoToMoviePageStep extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final filterFinder = find.byValueKey("movieFilter2");
    await FlutterDriverUtils.tap(world.driver, filterFinder);
    final moviePosterFinder = find.byValueKey("moviePoster");
    await FlutterDriverUtils.tap(world.driver, moviePosterFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I go to a movie's page");
}

class EnterTextToComment extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String commentText, String commentBar) async {
// TODO: implement executeStep
    final commentBarFinder = find.byValueKey(commentBar);
    await FlutterDriverUtils.enterText(world.driver,commentBarFinder, commentText);
  }
  @override
  RegExp get pattern => RegExp(r"I enter {string} to the {string}");
}

class CheckCommentExists extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String commentText) async {
// TODO: implement executeStep
    final commentFinder = find.text(commentText);
    bool isCommentVisible = await FlutterDriverUtils.isPresent(world.driver, commentFinder);

    expect(isCommentVisible, true);
  }
  @override
  RegExp get pattern => RegExp(r"I should see {string} in the comment section");
}

/*
class PressPostButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String postButton) async {
// TODO: implement executeStep
    final postButtonFinder = find.byValueKey(postButton);
    await FlutterDriverUtils.tap(world.driver, postButtonFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I enter {string} to the {string}");
}

 */

