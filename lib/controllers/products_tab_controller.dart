import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsTabController extends GetxController {
  final List<ProductModel> _searchResult = [
    ProductModel(
        id: 69,
        title: "dummy",
        description: "vsv",
        price: 69,
        weight: 1,
        length: 1,
        width: 1,
        height: 1,
        quantity: 1,
        sellQuantity: 1,
        maxPurchaseQty: 1,
        minPurchaseQty: 1,
        active: true,
        upc: "f",
        sku: "",
        images: [],
        categories: [],
        brand: BrandModel(id: 1, title: "title", image: "image"),
        ownerId: 5)
  ];
  List<ProductModel> get searchResult => _searchResult;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool _searchEnabled = false;
  bool get searchEnabled => _searchEnabled;

  void toggleSearchState(bool val) {
    _searchEnabled = val;
    update();
  }

  Future search() async {
    _searchResult.clear();
    _searchResult.addAll([]);
    update();
  }
}
