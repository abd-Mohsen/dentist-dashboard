import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class ThemeController extends GetxController {
  bool _switchValue = Get.isDarkMode;
  bool get switchValue => _switchValue;

  void updateTheme(bool value) {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      _switchValue = false;
      window.localStorage['is dark'] = "false";
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      _switchValue = true;
      window.localStorage['is dark'] = "true";
    }
    update();
  }

  ThemeMode getThemeMode() {
    //todo: method being called twice at launch and once when changing language
    if (window.localStorage['is dark'] == null) {
      print("light");
      _switchValue = false;
      return ThemeMode.light;
    } else if (window.localStorage['is dark']! == "true") {
      print("dark");
      _switchValue = true;
      return ThemeMode.dark;
    } else if (window.localStorage['is dark']! == "true") {
      print("dark");
      _switchValue = true;
      return ThemeMode.dark;
    } else {
      print("default");
      return ThemeMode.light;
    }
  }
}
