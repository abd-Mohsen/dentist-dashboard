import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dentist_dashboard/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsTabController extends GetxController {
  final List<ProductModel> _searchResult = [];
  List<ProductModel> get searchResult => _searchResult;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final ScrollController suggestionsScrollController = ScrollController();

  bool _searchEnabled = false;
  bool get searchEnabled => _searchEnabled;

  void toggleSearchState(bool val) {
    _searchEnabled = val;
    if (!val) searchFocusNode.unfocus();
    update();
  }

  //todo: make a request every one second or so, not on every query change
  Future search() async {
    _searchResult.clear();
    await Future.delayed(Duration(milliseconds: 500));
    if (searchController.text.trim() != "") {
      _searchResult.addAll((await RemoteServices.searchProducts(searchController.text))!);
    }
    update();
  }
}
