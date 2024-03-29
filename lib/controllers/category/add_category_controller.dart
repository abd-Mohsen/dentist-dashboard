import 'dart:async';
import 'dart:typed_data';
import 'dart:js' as js;
import 'package:dentist_dashboard/models/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../services/remote_services.dart';

class AddCategoryController extends GetxController {
  GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  bool buttonPressed = false;

  @override
  void onInit() {
    getMainCategories();
    super.onInit();
  }

  final TextEditingController title = TextEditingController();
  CategoryModel? mainCategory;

  Uint8List newImg = Uint8List(8);
  bool isNewImgSelected = false;

  List<CategoryModel> childCategories = [];

  Future<void> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      newImg = await image.readAsBytes();
      isNewImgSelected = true;
      update();
    }
  }

  void setMainCategory(CategoryModel category) {
    mainCategory = category;
    update();
  }

  Future<void> getMainCategories() async {
    childCategories.addAll((await RemoteServices.fetchAllMainCategories())!);
  }

  Future<void> addCategory() async {
    buttonPressed = true;
    bool valid = addCategoryFormKey.currentState!.validate();
    if (!valid) return;
    if (!isNewImgSelected) {
      js.context.callMethod('alert', ['select an image'.tr]);
      return;
    }
    bool success = false;
    try {
      print("before");
      success = (await RemoteServices.createCategory(
        newImg,
        title.text,
        mainCategory?.title,
      ).timeout(kTimeOutDuration));
      print("after");
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error" + e.toString());
    } finally {
      if (success) {
        Get.back();
        js.context.callMethod('alert', ['added successfully'.tr]);
        Get.delete<AddCategoryController>();
      }
    }
  }
}
