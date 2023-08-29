import 'package:dentist_dashboard/layout.dart';
import 'package:dentist_dashboard/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController t = Get.put(ThemeController()); //to get the initial theme
    LocaleController l = LocaleController(); //to get the initial language
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      locale: l.initialLang,
      theme: MyThemes.myLightMode,
      darkTheme: MyThemes.myDarkMode,
      themeMode: t.getThemeMode(),
      home: Layout(),
    );
  }
}
