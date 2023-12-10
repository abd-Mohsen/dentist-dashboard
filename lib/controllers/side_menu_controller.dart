import 'package:dentist_dashboard/models/side_menu_model.dart';
import 'package:dentist_dashboard/views/analytics/analytics_view.dart';
import 'package:dentist_dashboard/views/brands/brands_tab.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../views/home/home_tab.dart';
import '../views/orders/orders_view.dart';
import '../views/products/products_tab.dart';
import '../views/users/users_tab.dart';

class SideMenuController extends GetxController {
  final List<MenuModel> sideMenuItems = [
    MenuModel(title: "Home".tr, icon: Icons.home_filled, isSelected: true, route: 'home', tab: 0),
    //MenuModel(title: "layout products".tr, icon: Icons.phone_android, isSelected: false, isHovered: false),
    MenuModel(title: "products".tr, icon: Icons.manage_search, isSelected: false, route: "products", tab: 1),
    //MenuModel(title: "Manage categories".tr, icon: Icons.category_rounded, isSelected: false, route: "products"),
    MenuModel(title: "users".tr, icon: Icons.manage_accounts, isSelected: false, route: "users", tab: 2),
    MenuModel(title: "orders".tr, icon: Icons.checklist, isSelected: false, route: "orders", tab: 3),
    MenuModel(title: "Analytics".tr, icon: Icons.analytics, isSelected: false, route: "analytics", tab: 4),
    MenuModel(title: "brands".tr, icon: Icons.tag, isSelected: false, route: "products", tab: 5),
  ];

  List<Widget> tabs = [
    HomeTab(),
    ProductsTab(),
    UsersTab(),
    OrdersTab(),
    AnalyticsTab(),
    BrandsTab(),
  ];

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  void toggleActiveItem(MenuModel item) {
    for (MenuModel model in sideMenuItems) {
      model.isSelected = false;
    }
    item.isSelected = true;
    _selectedTab = item.tab;
    update();
  }

  bool topTab(int i) => i == _selectedTab - 1 && i >= 0 && i < sideMenuItems.length;

  bool bottomTab(int i) => i == _selectedTab + 1 && i >= 0 && i < sideMenuItems.length;
}
