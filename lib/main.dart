import 'package:dentist_dashboard/layout.dart';
import 'package:dentist_dashboard/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: MyThemes.myLightMode,
      darkTheme: MyThemes.myDarkMode,
      home: Layout(),
    );
  }
}
