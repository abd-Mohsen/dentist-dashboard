import 'dart:async';
import 'dart:typed_data';
import 'dart:js' as js;
import 'package:dentist_dashboard/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  bool _editingMode = false;
  bool get editingMode => _editingMode;
  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }

  bool _editPassMode = false;
  bool get editPassMode => _editPassMode;
  void toggleEditPassMode(bool val) {
    _editPassMode = val;
    update();
  }

  final UserModel user;

  UserController({required this.user});

  @override
  void onInit() {
    name.text = user.name;
    phone.text = user.phone;
    super.onInit();
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController currPassword = TextEditingController();

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

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

  Future<void> editProfile() async {
    buttonPressed = true;
    bool success = false;
    bool valid = userFormKey.currentState!.validate();
    if (!valid) return;
    try {
      print("before");
      success = (await RemoteServices.editProfile(
        name.text,
        phone.text,
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

  Future<void> editPassword() async {
    buttonPressed = true;
    bool success = false;
    bool valid = passwordFormKey.currentState!.validate();
    if (!valid) return;
    try {
      print("before");
      success = (await RemoteServices.editPassword(
        password.text,
        currPassword.text,
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

  Future<void> editProfileImage() async {
    buttonPressed = true;
    bool success = false;
    if (!isNewImgSelected) return;
    try {
      print("before");
      success = (await RemoteServices.uploadProfileImage(newImg).timeout(kTimeOutDuration));
      print("after");
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error" + e.toString());
    } finally {
      if (success) {
        js.context.callMethod('alert', ['photo ${'updated successfully'.tr}']);
        //isNewImgSelected = false;
        //update();
      }
    }
  }

  Future<void> deleteUser() async {
    //bool success = false;
    try {
      //success = await RemoteServices.deleteBrand(user.id).timeout(kTimeOutDuration);
    } on TimeoutException {
      js.context.callMethod('alert', ['request timed out'.tr]);
    } catch (e) {
      print("catch error $e");
    } finally {
      // if (success) {
      //   Get.back();
      //   js.context.callMethod('alert', ['deleted successfully'.tr]);
      //   Get.delete<UserController>();
      // }
    }
  }
}
