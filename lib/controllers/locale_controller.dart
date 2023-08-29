import 'package:universal_html/html.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController {
  late Locale _initLocale;
  Locale get initialLang => _initLocale;

  LocaleController() {
    loadInitLocale();
  }

  void updateLocale(String langCode) {
    window.localStorage["lang"] = langCode;
    Get.updateLocale(Locale(langCode));
  }

  String getCurrentLanguageLabel() {
    final currentLang = window.localStorage["lang"];
    if (currentLang == "ar") {
      return "Arabic ".tr;
    } else if (currentLang == "en") {
      return "English ".tr;
    } else {
      return Get.deviceLocale!.languageCode; //todo
    }
  }

  void loadInitLocale() {
    _initLocale = Locale(window.localStorage["lang"] ?? "en");
  }
}
