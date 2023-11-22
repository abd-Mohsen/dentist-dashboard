import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BrandController extends GetxController {
  bool _editingMode = false;
  bool get editingMode => _editingMode;
  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }

  GlobalKey<FormState> brandFormKey = GlobalKey<FormState>();
}
