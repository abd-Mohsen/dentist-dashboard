import 'package:dentist_dashboard/models/side_menu_model.dart';
import 'package:dentist_dashboard/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SideMenuController extends GetxController {
  final List<MenuModel> sideMenuItems = [
    MenuModel(title: "Home".tr, icon: Icons.home_filled, isSelected: true, isHovered: false),
    MenuModel(title: "layout products".tr, icon: Icons.phone_android, isSelected: false, isHovered: false),
    MenuModel(title: "Manage products".tr, icon: Icons.manage_search, isSelected: false, isHovered: false),
    MenuModel(title: "Manage users".tr, icon: Icons.manage_accounts, isSelected: false, isHovered: false),
    MenuModel(title: "Manage orders".tr, icon: Icons.checklist, isSelected: false, isHovered: false),
    MenuModel(title: "Analytics".tr, icon: Icons.analytics, isSelected: false, isHovered: false),
    MenuModel(title: "Analytics".tr, icon: Icons.analytics, isSelected: false, isHovered: false),
  ];

  void toggleActiveItem(MenuModel item) {
    for (MenuModel model in sideMenuItems) {
      model.isSelected = false;
    }
    item.isSelected = true;
    update();
  }

  void onHover(MenuModel item) {
    for (MenuModel model in sideMenuItems) {
      model.isHovered = false;
    }
    item.isHovered = true;
    update();
  }
}
