import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/controllers/navigation_controller.dart';
import 'package:dentist_dashboard/layout.dart';
import 'package:dentist_dashboard/themes.dart';
import 'package:dentist_dashboard/views/analytics_tabs/analytics_view.dart';
import 'package:dentist_dashboard/views/home_tabs/home_view.dart';
import 'package:dentist_dashboard/views/login_view.dart';
import 'package:dentist_dashboard/views/orders_tabs/orders_view.dart';
import 'package:dentist_dashboard/views/product_tabs/products_view.dart';
import 'package:dentist_dashboard/views/redirect.dart';
import 'package:dentist_dashboard/views/users_tabs/users_view.dart';
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
    Get.put(NavigationController());
    LocaleController l = LocaleController(); //to get the initial language
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      locale: l.initialLang,
      theme: MyThemes.myLightMode,
      darkTheme: MyThemes.myDarkMode,
      themeMode: t.getThemeMode(),
      home: const LoginView(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => RedirectPage()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/dashboard', page: () => Layout()),
        GetPage(name: '/dashboard/$kHomeViewRoute', page: () => HomeView()),
        GetPage(name: '/dashboard/$kProductsViewRoute', page: () => ProductsView()),
        GetPage(name: '/dashboard/$kUsersViewRoute', page: () => UsersView()),
        GetPage(name: '/dashboard/$kOrdersViewRoute', page: () => OrdersView()),
        GetPage(name: '/dashboard/$kAnalyticsViewRoute', page: () => AnalyticsView()),
      ],
    );
  }
}
