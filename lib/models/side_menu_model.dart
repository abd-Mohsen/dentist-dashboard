import 'package:flutter/material.dart';

class MenuModel {
  String title;
  IconData icon;
  bool isSelected;
  bool isHovered;

  MenuModel({required this.title, required this.icon, required this.isSelected, required this.isHovered});
}
