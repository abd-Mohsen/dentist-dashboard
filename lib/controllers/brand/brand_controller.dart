import 'dart:async';
import 'dart:typed_data';
import 'dart:js' as js;
import 'package:file_picker/file_picker.dart';
import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/services/remote_services.dart';
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

  // void startWebFilePicker() async {
  //   final uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     final file = files![0];
  //     final reader = html.FileReader();
  //
  //     reader.onLoadEnd.listen((event) {
  //       final newImg = const Base64Decoder().convert(reader.result.toString().split(",").last);
  //       //updateBrand(newImg, brandTitle, brandId);
  //     });
  //
  //     reader.readAsDataUrl(file);
  //   });
  // }

  List<PlatformFile>? _paths;

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg'],
      ))
          ?.files;
    } catch (e) {
      print(e.toString());
    }
    newImg = _paths!.first.bytes!;
    isNewImgSelected = true;
    update();
  }

  Future<void> editBrand() async {
    buttonPressed = true;
    bool success = false;
    bool valid = brandFormKey.currentState!.validate();
    if (!valid) return;
    try {
      print("before");
      success = (await RemoteServices.updateBrand(
        isNewImgSelected ? newImg : null,
        title.text,
        brand.id,
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

  Future<void> deleteBrand() async {
    bool success = false;
    try {
      success = await RemoteServices.deleteBrand(brand.id).timeout(kTimeOutDuration);
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error $e");
    } finally {
      if (success) {
        Get.back();
        js.context.callMethod('alert', ['deleted successfully'.tr]);
        Get.delete<BrandController>();
      }
    }
  }
}
