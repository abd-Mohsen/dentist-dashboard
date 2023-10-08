import 'package:dentist_dashboard/models/side_menu_model.dart';
import 'package:dentist_dashboard/routes.dart';
import 'package:dentist_dashboard/views/analytics_tabs/analytics_view.dart';
import 'package:dentist_dashboard/views/home_tabs/home_view.dart';
import 'package:dentist_dashboard/views/orders_tabs/orders_view.dart';
import 'package:dentist_dashboard/views/product_tabs/products_view.dart';
import 'package:dentist_dashboard/views/users_tabs/users_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class SideMenuController extends GetxController {
  final List<MenuModel> sideMenuItems = [
    MenuModel(title: "Home".tr, icon: Icons.home_filled, isSelected: true, route: 'home', tab: HomeView()),
    //MenuModel(title: "layout products".tr, icon: Icons.phone_android, isSelected: false, isHovered: false),
    MenuModel(
        title: "Manage products".tr,
        icon: Icons.manage_search,
        isSelected: false,
        route: "products",
        tab: ProductsView()),
    //MenuModel(title: "Manage brands".tr, icon: Icons.tag, isSelected: false, route: "products"),
    //MenuModel(title: "Manage categories".tr, icon: Icons.category_rounded, isSelected: false, route: "products"),
    MenuModel(
        title: "Manage users".tr, icon: Icons.manage_accounts, isSelected: false, route: "users", tab: UsersView()),
    MenuModel(title: "Manage orders".tr, icon: Icons.checklist, isSelected: false, route: "orders", tab: OrdersView()),
    MenuModel(
        title: "Analytics".tr, icon: Icons.analytics, isSelected: false, route: "analytics", tab: AnalyticsView()),
  ];

  Widget _selectedTab = const HomeView();
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
