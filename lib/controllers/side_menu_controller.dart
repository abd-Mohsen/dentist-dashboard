import 'package:dentist_dashboard/models/side_menu_model.dart';
import 'package:dentist_dashboard/views/analytics_tabs/analytics_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../views/home/home_tab.dart';
import '../views/orders/orders_view.dart';
import '../views/products/products_tab.dart';
import '../views/users/users_view.dart';

class SideMenuController extends GetxController {
  final List<MenuModel> sideMenuItems = [
    MenuModel(title: "Home".tr, icon: Icons.home_filled, isSelected: true, route: 'home', tab: const HomeTab()),
    //MenuModel(title: "layout products".tr, icon: Icons.phone_android, isSelected: false, isHovered: false),
    MenuModel(
        title: "Manage products".tr,
        icon: Icons.manage_search,
        isSelected: false,
        route: "products",
        tab: const ProductsTab()),
    //MenuModel(title: "Manage brands".tr, icon: Icons.tag, isSelected: false, route: "products"),
    //MenuModel(title: "Manage categories".tr, icon: Icons.category_rounded, isSelected: false, route: "products"),
    MenuModel(
        title: "Manage users".tr,
        icon: Icons.manage_accounts,
        isSelected: false,
        route: "users",
        tab: const UsersTab()),
    MenuModel(
        title: "Manage orders".tr, icon: Icons.checklist, isSelected: false, route: "orders", tab: const OrdersTab()),
    MenuModel(
        title: "Analytics".tr, icon: Icons.analytics, isSelected: false, route: "analytics", tab: const AnalyticsTab()),
  ];

  Widget _selectedTab = const HomeTab();
  Widget get selectedTab => _selectedTab;

  void toggleActiveItem(MenuModel item) {
    for (MenuModel model in sideMenuItems) {
      model.isSelected = false;
    }
    item.isSelected = true;
    _selectedTab = item.tab;
    //js.context.callMethod('alert', [item.route]);
    //Get.toNamed('/${item.route}');
    update();
  }

  // void onHover(MenuModel item) {
  //   for (MenuModel model in sideMenuItems) {
  //     model.isHovered = false;
  //   }
  //   item.isHovered = true;
  //   update();
  // }
}
