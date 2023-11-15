import 'package:get/get.dart';

class ProductController extends GetxController {
  int _imageIndex = 0;
  int get imageIndex => _imageIndex;

  void changeIndex(int i) {
    _imageIndex = i;
    update();
  }

  void toRight(int max) {
    if (_imageIndex == max) return;
    _imageIndex++;
    update();
  }

  void toLeft() {
    if (_imageIndex == 0) return;
    _imageIndex++;
    update();
  }

  bool _editingMode = false;

  bool get editingMode => _editingMode;

  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }
}
