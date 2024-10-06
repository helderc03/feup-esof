import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgetsLG
    extends Given3WithWorld<String,String,String,FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2, String input3) async {
// TODO: implement executeStep
    final textInput1 = find.byValueKey(input1);
    final textInput2 = find.byValueKey(input2);
    final button = find.byValueKey(input3);
    bool input1Exists = await FlutterDriverUtils.isPresent(world.driver, textInput1);
    bool input2Exists = await FlutterDriverUtils.isPresent(world.driver,textInput2);
    bool buttonExists = await FlutterDriverUtils.isPresent(world.driver, button);
    expect(input1Exists, true);
    expect(input2Exists, true);
    expect(buttonExists, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I have {string} and {string} and {string}");
}

class EnterEmail extends When2WithWorld<String,String, FlutterWorld> {
  @override
  Future<void> executeStep(String emailField, String email) async {
// TODO: implement executeStep
    final emailInputFinder = find.byValueKey(emailField);
    await FlutterDriverUtils.tap(world.driver, emailInputFinder);
    await FlutterDriverUtils.enterText(world.driver,emailInputFinder, email);
  }
  @override
  RegExp get pattern => RegExp(r"I fill {string} with {string}");
}

class EnterPassword extends And2WithWorld<String,String, FlutterWorld> {
  @override
  Future<void> executeStep(String passwordField, String password) async {
// TODO: implement executeStep
    final passwordInputFinder = find.byValueKey(passwordField);
    await FlutterDriverUtils.tap(world.driver, passwordInputFinder);
    await FlutterDriverUtils.enterText(world.driver,passwordInputFinder, password);
  }
  @override
  RegExp get pattern => RegExp(r"I fill {string} with {string}");
}

class ClickLoginButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String Btn) async {
// TODO: implement executeStep
    final btnFinder = find.byValueKey(Btn);
    await FlutterDriverUtils.tap(world.driver, btnFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I click the {string}");
}

class VerifyHomePage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String expectedPage) async {
    final homePageFinder = find.byValueKey(expectedPage);
    await Future.delayed(Duration(seconds: 7));
    bool isHomePageVisible = await FlutterDriverUtils.isPresent(world.driver, homePageFinder);
    expect(isHomePageVisible, true);
  }

  @override
  RegExp get pattern => RegExp(r"I should have {string} on screen");
}

