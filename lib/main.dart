import 'package:dentist_dashboard/controllers/navigation_controller.dart';
import 'package:dentist_dashboard/layout.dart';
import 'package:dentist_dashboard/themes.dart';
import 'package:dentist_dashboard/views/analytics_tabs/analytics_view.dart';
import 'package:dentist_dashboard/views/home/home_tab.dart';
import 'package:dentist_dashboard/views/login_view.dart';
import 'package:dentist_dashboard/views/orders/orders_view.dart';
import 'package:dentist_dashboard/views/products/products_tab.dart';
import 'package:dentist_dashboard/views/redirect.dart';
import 'package:dentist_dashboard/views/users/users_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController t = Get.put(ThemeController()); //to get the initial theme
    Get.put(NavigationController());
    LocaleController l = LocaleController(); //to get the initial language
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      locale: l.initialLang,
      theme: MyThemes.myLightMode,
      darkTheme: MyThemes.myDarkMode,
      themeMode: t.getThemeMode(),
      //home: const RedirectPage(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const RedirectPage()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/dashboard', page: () => const Layout()),
        GetPage(name: '/home', page: () => const HomeTab()),
        GetPage(name: '/products', page: () => const ProductsTab()),
        GetPage(name: '/users', page: () => const UsersTab()),
        GetPage(name: '/orders', page: () => const OrdersTab()),
        GetPage(name: '/analytics', page: () => const AnalyticsTab()),
      ],
    );
  }
}
