import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckSignUpPage
    extends Given1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
// TODO: implement executeStep
    final signUpPageButton = find.byValueKey("GoToSignUp");
    await FlutterDriverUtils.tap(world.driver, signUpPageButton);
    final signUpPageFinder = find.byValueKey(input1);
    bool isSignUpPageVisible = await FlutterDriverUtils.isPresent(world.driver, signUpPageFinder);
    expect(isSignUpPageVisible, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I am on the {string}");
}

class WidgetCheckSignUp
    extends And4WithWorld<String,String,String,String,FlutterWorld> {
  @override
  Future<void> executeStep(String i1, String i2, String i3,String i4) async {
// TODO: implement executeStep
    final tI1 = find.byValueKey(i1);
    final tI2 = find.byValueKey(i2);
    final tI3 = find.byValueKey(i3);
    final btn = find.byValueKey(i4);
    bool i1Exists = await FlutterDriverUtils.isPresent(world.driver, tI1);
    bool i2Exists = await FlutterDriverUtils.isPresent(world.driver,tI2);
    bool i3Exists = await FlutterDriverUtils.isPresent(world.driver,tI3);
    bool bExists = await FlutterDriverUtils.isPresent(world.driver, btn);
    expect(i1Exists, true);
    expect(i2Exists, true);
    expect(i3Exists, true);
    expect(bExists, true);
  }
  @override
// TODO: implement pattern
  RegExp get pattern => RegExp(r"I have {string} and {string} and {string} and {string}");
}

class EnterText extends When2WithWorld<String,String, FlutterWorld> {
  @override
  Future<void> executeStep(String textField, String text) async {
// TODO: implement executeStep
    final textInputFinder = find.byValueKey(textField);
    await FlutterDriverUtils.tap(world.driver, textInputFinder);
    await FlutterDriverUtils.enterText(world.driver,textInputFinder, text);
  }
  @override
  RegExp get pattern => RegExp(r"I fill {string} with {string}");
}

class ClickSignUpButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String loginBtn) async {
// TODO: implement executeStep
    final loginFinder = find.byValueKey(loginBtn);
    await FlutterDriverUtils.tap(world.driver, loginFinder);
  }
  @override
  RegExp get pattern => RegExp(r"I click the {string}");
}