import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BrandController extends GetxController {
  bool _editingMode = false;
  bool get editingMode => _editingMode;
  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }

  final BrandModel brand;

  BrandController({required this.brand});

  @override
  void onInit() {
    title.text = brand.title;
    super.onInit();
  }

  final TextEditingController title = TextEditingController();

  GlobalKey<FormState> brandFormKey = GlobalKey<FormState>();
}
