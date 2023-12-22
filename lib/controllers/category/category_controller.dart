import 'dart:async';
import 'dart:typed_data';
import 'dart:js' as js;
import 'package:dentist_dashboard/models/category_model.dart';
import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  bool _editingMode = false;
  bool get editingMode => _editingMode;
  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }

  final CategoryModel category;

  CategoryController({required this.category});

  @override
  void onInit() {
    title.text = category.title;
    super.onInit();
  }

  final TextEditingController title = TextEditingController();

  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  bool buttonPressed = false;

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

  Future<void> editCategory() async {
    buttonPressed = true;
    bool success = false;
    bool valid = categoryFormKey.currentState!.validate();
    if (!valid) return;
    try {
      print("before");
      success = (await RemoteServices.updateCategory(
        isNewImgSelected ? newImg : null,
        title.text,
        category.id,
        "parent",
      ).timeout(kTimeOutDuration));
      print("after");
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error" + e.toString());
    } finally {
      if (success) js.context.callMethod('alert', ['updated successfully'.tr]);
    }
  }

  Future<void> deleteCategory() async {
    bool success = false;
    try {
      success = await RemoteServices.deleteCategory(category.id).timeout(kTimeOutDuration);
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error $e");
    } finally {
      if (success) {
        Get.back();
        js.context.callMethod('alert', ['deleted successfully'.tr]);
        Get.delete<CategoryController>();
      }
    }
  }
}
