import 'package:get/get.dart';

class ProductController extends GetxController {
  int _imageIndex = 0;
  int get imageIndex => _imageIndex;

  void changeIndex(int i) {
    _imageIndex = i;
    update();
  }
}
