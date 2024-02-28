import 'package:dentist_dashboard/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductController({required this.product});
  final ProductModel product;

  @override
  void onInit() {
    title.text = product.title;
    description.text = product.description;
    price.text = product.price.toString();
    weight.text = product.weight.toString();
    length.text = product.length.toString();
    width.text = product.width.toString();
    height.text = product.height.toString();
    super.onInit();
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController(); // add validation
  final TextEditingController height = TextEditingController();
  final TextEditingController length = TextEditingController();
  final TextEditingController width = TextEditingController();
  final TextEditingController weight = TextEditingController();

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
    _imageIndex--;
    update();
  }

  bool _editingMode = false;
  bool get editingMode => _editingMode;
  void toggleEditMode(bool val) {
    _editingMode = val;
    update();
  }

  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  bool buttonPressed = false;
}
