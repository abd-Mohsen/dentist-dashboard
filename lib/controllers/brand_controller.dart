import 'dart:typed_data';

import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Uint8List newImg = Uint8List(8);
  bool isNewImgSelected = false;

  Future<void> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      newImg = await image.readAsBytes();
      isNewImgSelected = true;
      update();
    }
  }
}
