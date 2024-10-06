import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class LogInStep extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final emailInputFinder = find.byValueKey("emailField");
    await FlutterDriverUtils.tap(world.driver, emailInputFinder);
    await FlutterDriverUtils.enterText(world.driver, emailInputFinder, "a@gmail.com");

    final passwordInputFinder = find.byValueKey("passwordField");
    await FlutterDriverUtils.tap(world.driver, passwordInputFinder);
    await FlutterDriverUtils.enterText(world.driver, passwordInputFinder, "123456");

    final loginButtonFinder = find.byValueKey("loginButton");
    await FlutterDriverUtils.tap(world.driver, loginButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r"I log in");
}


class ProfilePageCheck
    extends Given1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
// TODO: implement executeStep
    final ProfilePageButton = find.byValueKey("ProfilePageIcon");
    await FlutterDriverUtils.tap(world.driver, ProfilePageButton);
    final ProfilePageFinder = find.byValueKey(input1);
    bool isProfilePageVisible = await FlutterDriverUtils.isPresent(world.driver, ProfilePageFinder);
    expect(isProfilePageVisible, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I go to the {string}");
}

class CheckLogOutButton
    extends Given1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String logOutButton) async {
// TODO: implement executeStep
    final lOButtonFinder = find.byValueKey(logOutButton);
    bool lOButtonExists = await FlutterDriverUtils.isPresent(world.driver, lOButtonFinder);
    expect(lOButtonExists, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I have a {string}");
}

class VerifyLoginPage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String LoginPage) async {
    final loginPageFinder = find.byValueKey(LoginPage);
    bool isLoginPageVisible = await FlutterDriverUtils.isPresent(world.driver, loginPageFinder);
    expect(isLoginPageVisible, true);
  }

  @override
  RegExp get pattern => RegExp(r"I should have {string} on my screen");
}

