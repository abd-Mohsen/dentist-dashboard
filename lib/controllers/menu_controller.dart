import 'package:dentist_dashboard/models/menu_model.dart';
import 'package:dentist_dashboard/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// todo: create
class MenuController extends GetxController {
  List<MenuModel> sideMenuItems = [
    MenuModel(true, false),
    MenuModel(false, false),
    MenuModel(false, false),
    MenuModel(false, false),
  ];

  // MenuModel activeItem = sideMenuItems[];
  // late MenuModel hoverItem;

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
