import 'package:dentist_dashboard/models/side_menu_model.dart';
import 'package:dentist_dashboard/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class SideMenuController extends GetxController {
  final List<MenuModel> sideMenuItems = [
    MenuModel(title: "Home".tr, icon: Icons.home_filled, isSelected: true, route: 'home'),
    //MenuModel(title: "layout products".tr, icon: Icons.phone_android, isSelected: false, isHovered: false),
    MenuModel(title: "Manage products".tr, icon: Icons.manage_search, isSelected: false, route: "products"),
    MenuModel(title: "Manage brands".tr, icon: Icons.tag, isSelected: false, route: "products"),
    MenuModel(title: "Manage categories".tr, icon: Icons.category_rounded, isSelected: false, route: "products"),
    MenuModel(title: "Manage users".tr, icon: Icons.manage_accounts, isSelected: false, route: "users"),
    MenuModel(title: "Manage orders".tr, icon: Icons.checklist, isSelected: false, route: "orders"),
    MenuModel(title: "Analytics".tr, icon: Icons.analytics, isSelected: false, route: "analytics"),
  ];

  void toggleActiveItem(MenuModel item) {
    for (MenuModel model in sideMenuItems) {
      model.isSelected = false;
    }
    js.context.callMethod('alert', [item.route]);
    item.isSelected = true;
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
