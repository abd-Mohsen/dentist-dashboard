import 'package:dentist_dashboard/models/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../services/remote_services.dart';

class CategoriesTabController extends GetxController {
  final List<CategoryModel> _searchResult = [];
  List<CategoryModel> get searchResult => _searchResult;

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
  //todo: result is being duplicated when typing so fast
  Future search() async {
    _searchResult.clear();
    if (searchController.text.trim() != "") {
      _searchResult.clear();
      _searchResult.addAll((await RemoteServices.searchCategories(searchController.text))!);
    }
    print(_searchResult);
    update();
  }
}
