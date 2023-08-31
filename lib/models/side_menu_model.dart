import 'package:flutter/material.dart';

class MenuModel {
  final String title;
  final IconData icon;
  bool isSelected;
  final String route;
  //bool isHovered;

  MenuModel({required this.title, required this.icon, required this.isSelected, required this.route});
}
